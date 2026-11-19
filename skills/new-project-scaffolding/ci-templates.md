# CI Templates by Project Type

## Principles

1. Fail fast — cheapest checks first (lint → type-check → unit → integration → e2e)
2. Cache aggressively (node_modules, pip cache, build artifacts)
3. Run tests in parallel where possible
4. Include a deploy step even if it's a placeholder

## Web App (Node.js / React / Next.js)

```yaml
name: CI
on: [push, pull_request]
jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm
      - run: npm ci
      - run: npm run lint
      - run: npm run typecheck
      - run: npm run test:unit
      - run: npm run test:e2e
      - run: npm run build
```

## Python (API / Package / CLI)

```yaml
name: CI
on: [push, pull_request]
jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: "3.12"
          cache: pip
      - run: pip install -e ".[dev]"
      - run: ruff check .
      - run: mypy .
      - run: pytest --tb=short
```

## Agent / Ops Service

Start from the Python template above, then add:

- a secret scan (gitleaks or similar) on every push, since these projects hold real credentials
- the policy-gate property tests and the eval suite as required jobs, with the eval thresholds failing the build
- a "policy changed" label or required review whenever files under `policy/` change
- deploy only to shadow mode from CI; turning an action type live is a human step

## iOS (Swift)

```yaml
name: CI
on: [push, pull_request]
jobs:
  build-and-test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - run: xcodebuild test -scheme AppName -destination 'platform=iOS Simulator,name=iPhone 15'
```

## Monorepo (Turborepo / Nx)

```yaml
name: CI
on: [push, pull_request]
jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm
      - run: npm ci
      - run: npx turbo lint typecheck test build --filter=...[origin/main]
```

## Deploy Placeholder

Always include at the bottom of any CI file, even if not yet wired up:

```yaml
  # deploy:
  #   needs: quality
  #   if: github.ref == 'refs/heads/main'
  #   runs-on: ubuntu-latest
  #   steps:
  #     - run: echo "Deploy step — configure for your target"
```
