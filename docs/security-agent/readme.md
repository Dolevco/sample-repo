# Sample Repo Documentation

## 1. Project Overview

This repository is a sample React Single Page Application (SPA) built with Vite and TypeScript. It serves as an example for the Security Agent tooling to scan front-end applications for security vulnerabilities, code quality issues, and configuration best practices.

Key characteristics:
- Framework: React 19.x
- Bundler: Vite 6.x
- Language: TypeScript 5.x
- Linting: ESLint with recommended plugins

## 2. Directory Structure

```
sample-repo/
├── public/                # Static assets (index.html, favicon, etc.)
├── src/                   # Source code
│   ├── App.tsx            # Root React component
│   ├── main.tsx           # Entry point mounting React
│   ├── index.css          # Global styles
│   ├── App.css            # Component styles
│   └── assets/            # Image and SVG assets
├── docs/                  # Documentation (Security Agent)
│   └── security-agent/
│       └── readme.md      # Central project documentation for security scanning
├── .gitignore             # Git ignore rules
├── eslint.config.js       # ESLint configuration
├── package.json           # NPM scripts and dependencies
├── tsconfig.json          # TypeScript base config
├── tsconfig.app.json      # TS config for application
├── tsconfig.node.json     # TS config for Node scripts
├── vite.config.ts         # Vite configuration
└── README.md              # Sample project README (generic)
```

## 3. Build & Development

Available NPM scripts (from `package.json`):

- `npm run dev`         : Run development server (Vite)
- `npm run build`       : Compile TypeScript and produce optimized build
- `npm run preview`     : Preview the production build locally
- `npm run lint`        : Run ESLint across the codebase

## 4. Dependencies & Tooling

Production Dependencies:
- react ^19.1.0
- react-dom ^19.1.0

Dev Dependencies:
- vite ^6.3.5
- typescript ~5.8.3
- @vitejs/plugin-react ^4.4.1
- eslint ^9.25.0
- @eslint/js, eslint-plugin-react-hooks, eslint-plugin-react-refresh
- @types/react, @types/react-dom

Overrides:
- cross-spawn pinned to 7.0.3 for compatibility

## 5. System Components & Relationships

- React components (under `src/`) represent UI modules.
- Vite handles module bundling and HMR during development.
- ESLint enforces code quality and security linting rules.
- TypeScript provides static typing and compile-time checks.

No server-side or cloud resources are present in this sample.

## 6. Security & Quality Considerations

- Ensure dependencies are up to date to mitigate known vulnerabilities.
- Use ESLint rules to detect common security anti-patterns (e.g., unsafe injections).
- Review Vite and plugin configurations for CORS, CSP, and other headers in production.

## 7. Future Planning

- Integration with CI pipelines for automated linting, building, and security scans.
- Add unit and security tests (Jest, Testing Library).
- Expand documentation with sample security policies and custom scanner configurations.
