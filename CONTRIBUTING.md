# Contributing to ORKS

Thank you for considering a contribution to the Open Research and Knowledge
Standard.

ORKS is maintained by one person. Contributions are welcome, but review,
discussion, and release timing are best effort and no response time is
guaranteed.

## Before contributing

1. Read the target repository's README, contribution guidance, and open
   issues. Repository-local instructions override this organization default.
2. For a substantial, security-sensitive, or compatibility-affecting change,
   open an issue first so its scope can be discussed before implementation.
3. Report vulnerabilities privately as described in the
   [Security Policy](SECURITY.md). Do not disclose vulnerability details in an
   issue or pull request.
4. Keep examples and test data synthetic or clearly licensed for public use.
   Never contribute secrets, private source material, credentials, personal
   data, raw prompts, model files, generated indexes, or local telemetry.

## Make a focused change

- Keep each pull request limited to one coherent outcome.
- Follow the target repository's formatting and verification commands.
- Add or update tests and documentation when behavior changes.
- Preserve provenance and third-party attribution.
- Distinguish facts, assumptions, proposals, and generated material.
- Use a clear commit message. Conventional Commit prefixes are preferred when
  they fit the change.

## Developer Certificate of Origin

All commits must be signed off under the
[Developer Certificate of Origin 1.1](DCO.md). A sign-off certifies that you
have the right to submit the contribution under the project's license. ORKS
uses DCO sign-off rather than a separate contributor license agreement.

Create a signed-off commit with:

```text
git commit --signoff
```

Git adds a trailer in this form:

```text
Signed-off-by: Your Name <your-email@example.com>
```

Use a real name and an email address you are authorized to use. The sign-off
must be present on every commit in the proposed history.

## Pull requests

A pull request should explain:

- the problem or user outcome;
- the chosen scope and any important tradeoffs;
- the verification performed;
- related issues or decisions, when applicable.

By contributing, you agree that your contribution is licensed under the
license of the repository receiving it. Public ORKS repositories use the
Apache License 2.0 unless the repository explicitly states otherwise.

Participation is governed by the [Code of Conduct](CODE_OF_CONDUCT.md).
