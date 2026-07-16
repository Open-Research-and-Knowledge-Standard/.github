#!/usr/bin/env bash
# Validate the public ORKS organization defaults with local command-line tools.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
FAILURES=0
cd "$REPO_ROOT"

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  FAILURES=$((FAILURES + 1))
}

printf '1. Required community files\n'
for path in \
  AGENTS.md \
  README.md \
  LICENSE \
  NOTICE \
  CONTRIBUTING.md \
  DCO.md \
  CODE_OF_CONDUCT.md \
  SECURITY.md \
  SUPPORT.md \
  profile/README.md \
  .github/PULL_REQUEST_TEMPLATE.md \
  .github/ISSUE_TEMPLATE/config.yml \
  .github/ISSUE_TEMPLATE/bug_report.yml \
  .github/ISSUE_TEMPLATE/conduct_report.yml \
  .github/ISSUE_TEMPLATE/feature_request.yml
do
  [ -f "$REPO_ROOT/$path" ] || fail "missing required file: $path"
done

printf '2. Shell and filesystem safety\n'
bash -n "$REPO_ROOT/scripts/validate-docs.sh" || fail "invalid validator syntax"
symlink="$(find "$REPO_ROOT" -type l -print -quit)"
[ -z "$symlink" ] || fail "repository symlink is not allowed: $symlink"
[ -x "$REPO_ROOT/scripts/validate-docs.sh" ] || fail "validator must be executable"
[ ! -e "$REPO_ROOT/.gitmodules" ] || fail "submodules are not allowed"
nested_git="$(find "$REPO_ROOT" -mindepth 2 -name .git -print -quit)"
[ -z "$nested_git" ] || fail "nested Git repository is not allowed: $nested_git"
[ ! -d "$REPO_ROOT/.github/workflows" ] || fail "workflows require separate approval"
for forbidden in codex.config.json claude.config.json directus.config.json; do
  match="$(find "$REPO_ROOT" -name "$forbidden" -print -quit)"
  [ -z "$match" ] || fail "forbidden runtime config: $match"
done

printf '3. Markdown links\n'
while IFS= read -r markdown; do
  while IFS= read -r raw_link; do
    target="${raw_link#*(}"
    target="${target%)}"
    target="${target%%#*}"
    target="${target#<}"
    target="${target%>}"
    case "$target" in
      ""|\#*|http://*|https://*|mailto:*|/*) continue ;;
    esac
    if [ ! -e "$(dirname "$markdown")/$target" ]; then
      fail "broken link in ${markdown#"$REPO_ROOT/"}: $target"
    fi
  done < <(grep -oE '\[[^]]+\]\([^)]*\)' "$markdown" || true)
done < <(find "$REPO_ROOT" -type f -name '*.md' -not -path '*/.git/*' -print | LC_ALL=C sort)

printf '4. Public-content boundary\n'
if rg -n '[^\x00-\x7F]' "$REPO_ROOT" --hidden --glob '!.git/**' >/dev/null; then
  fail "non-ASCII content found"
fi
if rg -n '\r$' "$REPO_ROOT" --hidden --glob '!.git/**' >/dev/null; then
  fail "CRLF line ending found"
fi
if rg -n '\b(TODO|TBD|FIXME|XXX)\b' "$REPO_ROOT" \
  --hidden --glob '!.git/**' --glob '!scripts/validate-docs.sh' >/dev/null; then
  fail "unresolved placeholder marker found"
fi
if rg -n \
  '(/home/|ProbablyComputers|pc-standards|Directus|BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY)' \
  "$REPO_ROOT" --hidden --glob '!.git/**' --glob '!AGENTS.md' \
  --glob '!scripts/validate-docs.sh' >/dev/null; then
  fail "private path, external authority, or credential marker found"
fi

printf '5. Template structure\n'
if command -v yamllint >/dev/null 2>&1; then
  if ! yamllint -d '{extends: relaxed, rules: {line-length: disable}}' \
    "$REPO_ROOT/.github/ISSUE_TEMPLATE/bug_report.yml" \
    "$REPO_ROOT/.github/ISSUE_TEMPLATE/conduct_report.yml" \
    "$REPO_ROOT/.github/ISSUE_TEMPLATE/config.yml" \
    "$REPO_ROOT/.github/ISSUE_TEMPLATE/feature_request.yml"; then
    fail "issue template YAML is invalid"
  fi
else
  printf 'SKIP: yamllint is unavailable; running structural checks only\n'
fi
for form in bug_report.yml feature_request.yml; do
  path="$REPO_ROOT/.github/ISSUE_TEMPLATE/$form"
  rg -q '^name:' "$path" || fail "$form lacks name"
  rg -q '^description:' "$path" || fail "$form lacks description"
  rg -q '^body:' "$path" || fail "$form lacks body"
  rg -q 'Code of Conduct' "$path" || fail "$form lacks conduct confirmation"
done
rg -q '^name: Code of Conduct report$' \
  "$REPO_ROOT/.github/ISSUE_TEMPLATE/conduct_report.yml" || \
  fail "conduct report form is missing"
rg -q 'This issue is public' \
  "$REPO_ROOT/.github/ISSUE_TEMPLATE/conduct_report.yml" || \
  fail "conduct report form lacks public-content warning"
rg -q '^blank_issues_enabled: false$' \
  "$REPO_ROOT/.github/ISSUE_TEMPLATE/config.yml" || \
  fail "blank issues must remain disabled"
rg -q 'Signed-off-by' "$REPO_ROOT/.github/PULL_REQUEST_TEMPLATE.md" || \
  fail "pull request template lacks DCO confirmation"
rg -q 'Developer Certificate of Origin' "$REPO_ROOT/CONTRIBUTING.md" || \
  fail "contribution guidance lacks DCO 1.1 policy"
rg -q 'Version 1.1' "$REPO_ROOT/DCO.md" || fail "DCO version is not 1.1"
rg -q 'Apache License' "$REPO_ROOT/LICENSE" || fail "Apache license text missing"
rg -q 'Adam Claassens' "$REPO_ROOT/NOTICE" || fail "public attribution missing"
rg -q 'private vulnerability reporting' "$REPO_ROOT/SECURITY.md" || \
  fail "security policy lacks private vulnerability reporting"
rg -q 'Do not include vulnerability details' "$REPO_ROOT/SECURITY.md" || \
  fail "security policy lacks public-disclosure warning"
rg -q 'best-effort' "$REPO_ROOT/SUPPORT.md" || \
  fail "support policy lacks best-effort scope"

if [ "$FAILURES" -ne 0 ]; then
  printf 'FAILED: %s validation issue(s)\n' "$FAILURES" >&2
  exit 1
fi

printf 'PASS: ORKS organization community documentation validation\n'
