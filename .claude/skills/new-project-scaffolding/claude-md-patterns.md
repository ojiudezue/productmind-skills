# CLAUDE.md Patterns by Project Type

## Universal Sections (always include)

```markdown
# [Project Name]

## Overview
[One paragraph: what this is, who it's for, what problem it solves]

## Tech Stack
- Language: 
- Framework: 
- Key dependencies: 

## Project Structure
[Tree of top-level directories with one-line descriptions]

## Code Conventions
- Naming: [camelCase/snake_case/PascalCase and where each applies]
- File organization: [by feature / by type / hybrid]
- Import order: [stdlib, third-party, local — or framework-specific]

## Testing
- Run all tests: `[command]`
- Run single test: `[command]`
- What to test: [business logic always, UI interactions, API contracts]
- What not to test: [generated code, third-party internals]

## Common Pitfalls
[3-5 things specific to this stack that cause bugs or confusion]
```

## Web App (React/Next.js)
Add: component patterns (server vs client), state management approach, API route conventions, environment variable handling, deployment target.

## iOS (Swift/SwiftUI)
Add: minimum iOS version, architecture pattern (MVVM/TCA), SwiftUI vs UIKit boundaries, Core Data or SwiftData usage, provisioning/signing notes.

## API Service (Node/Python)
Add: request/response patterns, authentication approach, database migration strategy, error handling conventions, logging format.

## CLI Tool
Add: argument parsing library, output formatting (JSON/table/plain), exit code conventions, config file location.

## Python Package
Add: packaging tool (setuptools/poetry/hatch), Python version support range, type annotation policy, docstring format.
