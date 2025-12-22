# Sample Repo

## Project Overview
This repository is a modern React + TypeScript template project using Vite as the build tool. It is designed to provide a robust starting point for building React applications with strict linting and type checking.

## Key Features
- React with TypeScript for type-safe UI development.
- Vite for fast development and optimized builds.
- ESLint configured with type-aware rules for code quality.

## Repository Structure
- `src/`: Contains the source code of the application.
- `package.json`: Defines project metadata, scripts, dependencies, and devDependencies.
- `tsconfig.json`: Main TypeScript configuration referencing app and node configs.
- `tsconfig.app.json`: TypeScript config for the app source with strict linting and JSX support.
- `tsconfig.node.json`: TypeScript config for node environment including Vite config.
- `vite.config.ts`: Configuration file for Vite enabling React plugin.

## Scripts
- `dev`: Starts the development server.
- `build`: Builds the application for production.
- `lint`: Runs ESLint to check code quality.
- `preview`: Previews the production build locally.

## ESLint Configuration
The project includes ESLint setup with type-aware rules to ensure code quality and consistency.

## Usage
1. Install dependencies:
```
npm install
```
2. Start development server:
```
npm run dev
```
3. Build for production:
```
npm run build
```
4. Run lint checks:
```
npm run lint
```

## Conclusion
This template provides a solid foundation for React + TypeScript projects with modern tooling and best practices for development and code quality.
