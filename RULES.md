# ORKS Organization Defaults Instructions

You are working in `.github`, the public organization-community repository for
the Open Research and Knowledge Standard.

## Authority and Ownership

- Repository ownership and the authority chain are declared once in the ORKS
  project profile and rendered into this repository's generated entry point.
  This file does not restate them.
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
- The project-wide work rules apply here unchanged and are not restated. They
  are declared once in the ORKS charter at
  `orks-planning/charter/working-rules.md`, which owns the rules on approval
  for workflows, secrets, apps and external services, ASCII usage, third-party
  attribution and licensing, Developer Certificate of Origin sign-off, and the
  repositories and runtimes a session may not load.

## Verification

- The verification command for this repository is `scripts/validate-docs.sh`,
  run from the repository root. It is repository-local knowledge and is named
  here because no canonical contract can carry it.
- Inspect the complete public diff for secrets and private content before
  proposing it. Everything committed here is published.

Session start and session end are otherwise owned by the canonical session
contract and by the ORKS runbooks, and are not restated here.
