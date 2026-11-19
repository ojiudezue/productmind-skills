# Testing by Project Type

## Web App (React/Next.js)

| Layer | Tool | What it covers |
|---|---|---|
| Unit | Vitest or Jest | Pure functions, hooks, utilities |
| Component | Testing Library | Component rendering, user interactions |
| E2E | Playwright | Full user flows across pages |
| Accessibility | axe-core / Playwright a11y | WCAG compliance |
| Visual regression | Playwright screenshots | UI drift detection |

Setup: `vitest.config.ts`, `playwright.config.ts`, sample test for each layer.

## iOS (Swift)

| Layer | Tool | What it covers |
|---|---|---|
| Unit | XCTest | Models, view models, services |
| UI | XCUITest | User flows, navigation |
| Snapshot | swift-snapshot-testing | View rendering consistency |
| Performance | XCTest measures | Response time, memory |

Setup: Test targets in Xcode project, sample test for each layer.

## API Service (Node.js)

| Layer | Tool | What it covers |
|---|---|---|
| Unit | Vitest/Jest | Handlers, services, utilities |
| Integration | Supertest | HTTP endpoints with real middleware |
| Contract | Pact or OpenAPI validation | API schema compliance |
| Load | k6 or autocannon | Throughput, latency under stress |

Setup: Test scripts in `package.json`, sample test for each layer, test database config.

## API Service (Python)

| Layer | Tool | What it covers |
|---|---|---|
| Unit | pytest | Functions, classes, services |
| Integration | httpx + pytest | Endpoint testing |
| Type checking | mypy | Static type safety |
| Property-based | Hypothesis | Edge case discovery |

Setup: `pytest.ini` or `pyproject.toml` config, conftest.py, sample test for each layer.

## CLI Tool

| Layer | Tool | What it covers |
|---|---|---|
| Unit | Language-native (pytest/vitest) | Core logic |
| Integration | bats (bash) or subprocess tests | Full command invocations |
| Snapshot | Custom or framework-specific | Output format stability |

Setup: Test config, sample tests, fixture files for input scenarios.

## Agent / Ops Service

Long-running agents and automation that act on real systems. Test what the agent is *allowed* to do as hard as what it computes.

| Layer | Tool | What it covers |
|---|---|---|
| Unit | pytest (or the stack's runner) | Collectors, parsers, detection rules |
| Policy gate (property-based) | Hypothesis | No input, however crafted, yields an action outside the menu, on a protected target, or over budget |
| Replay | Recorded logs/events + pytest | Run real history through detection and the gate; compare with what a human decided |
| Hostile input | Curated cases | Instructions hidden in log lines, hostnames, web pages and tool output do not change the agent's choices |
| Failure / chaos | Scripts | Agent killed mid-action, dependency down, credentials revoked: actions still expire and revert, it fails safe |
| Eval scoring | `evals/scoring.py` | Precision, false-positive rate and wrong-action count per action type, with pass thresholds that gate enablement |

Setup: a fixture directory of recorded inputs, a fake executor that records instead of acting, and a `shadow` flag that every action path checks.

## Python Package

| Layer | Tool | What it covers |
|---|---|---|
| Unit | pytest | All public API |
| Type checking | mypy (strict) | Full type safety |
| Property-based | Hypothesis | Invariant verification |
| Doctest | pytest --doctest-modules | Example correctness |

Setup: `pyproject.toml` test config, `tests/` mirroring `src/`, conftest.py.
