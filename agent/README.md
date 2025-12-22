# Sample Repo

## Overview
This repository is a minimal React + TypeScript project scaffolded with Vite. It is designed for fast development with Hot Module Replacement (HMR) and linting support.

## Repository Structure

- .gitignore: Git ignore rules.
- README.md: Project description and setup instructions.
- eslint.config.js: ESLint configuration.
- index.html: Main HTML file referencing /src/main.tsx as the entry point.
- package.json: Project metadata, scripts, and dependencies including React 19.1.0, Vite, TypeScript, and ESLint.
- package-lock.json: Dependency lock file.
- tsconfig.app.json, tsconfig.json, tsconfig.node.json: TypeScript configuration files.
- vite.config.ts: Vite configuration using React plugin.

## Source Directory (src)

- main.tsx: Main entry point for the React app.
- App.tsx: Main React component rendering a simple "Hello World!" message.
- App.css, index.css: CSS files for styling.
- vite-env.d.ts: Vite environment type declarations.

## Features

- React 19.1.0 with TypeScript for type-safe UI development.
- Vite as the build tool for fast bundling and development server.
- Hot Module Replacement (HMR) enabled for instant updates during development.
- ESLint configured with recommended and type-aware lint rules to maintain code quality.

## Usage

1. Install dependencies:
```
npm install
```
2. Run the development server:
```
npm run dev
```
3. Build for production:
```
npm run build
```
4. Preview production build:
```
npm run preview
```

## License

This project is licensed under the MIT License.
