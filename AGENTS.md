# ORKS Organization Defaults Instructions

You are working in `.github`, the public organization-community repository for
the Open Research and Knowledge Standard.

## Startup

1. Read the shared-parent `AGENTS.md`.
2. Read this file.
3. Read `orks-planning/sessions/current.md` and the active backlog contract.
4. Check Git status for every repository mounted in the session.
5. Identify the approved task and repository-local verification command before
   changing files.

## Authority and Ownership

- `orks-planning` is the source of truth for accepted product decisions,
  delivery state, risks, and repository boundaries.
- This repository owns organization profile and community-health defaults,
  contribution and DCO guidance, code of conduct, security and support policy,
  and issue and pull-request templates.
- Do not place normative ORKS standard text, project-specific build logic,
  secrets, release artifacts, or private planning material here.

## Work Rules

- Treat every committed file as public and organization-wide unless GitHub
  documents a narrower scope.
- Keep governance and support language accurate for a solo maintainer. Do not
  promise response times, funding, services, or teams that do not exist.
- Direct vulnerability reports to GitHub private vulnerability reporting, not
  public issues.
- Do not add workflows, repository secrets, apps, webhooks, Pages, or external
  service dependencies without explicit approval and security review.
- Use ASCII unless a public policy document requires otherwise.
- Preserve third-party attribution and licensing.
- Sign public commits under Developer Certificate of Origin 1.1.
- Do not load Directus, `pc-standards`, ProbablyComputers project authority,
  unrelated repositories, host-global MCP servers, plugins, apps, or agents.

## Closeout

Run the repository-local documentation validator and `git diff --check`,
inspect the public diff for secrets and private content, update the ORKS
planning handoff, and follow the planning repository's session-end runbook.
