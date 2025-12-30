# Sample Repo

## Overview
This is a React Single Page Application (SPA) built with Vite and TypeScript. It includes deployment infrastructure using Bicep templates in the `deployment/` directory. The app features a simple 'Hello World!' component and supports modern React hooks and utilities.

Key technologies:
- **React**: ^19.1.0 (with react-dom)
- **Vite**: ^6.3.5 (build tool and dev server)
- **TypeScript**: ~5.8.3
- **ESLint**: For code linting with React hooks and refresh plugins
- **Bicep**: For Azure infrastructure deployment

## Components
The source code is organized in the `src/` directory:

- **src/App.tsx**: Main application component rendering a simple 'Hello World!' heading in a container div. Uses CSS modules via `App.css`.
- **src/main.tsx**: Entry point that renders the App component into the DOM using ReactDOM (imported from react-dom/client).
- **src/App.css**: Styles for the App component, including container layout.
- **src/index.css**: Global styles, likely including Tailwind or base resets.
- **src/assets/react.svg**: Sample React logo asset.
- **src/vite-env.d.ts**: TypeScript declarations for Vite environment.

The app uses functional components with hooks support (via ESLint plugins). No additional utils or complex components present; it's a minimal starter template.

Directory structure:
```
src/
├── App.tsx
├── App.css
├── assets/
│   └── react.svg
├── index.css
├── main.tsx
└── vite-env.d.ts
```

## Build and Development

### Prerequisites
- Node.js (with npm)
- TypeScript

### Scripts (from package.json)
- `npm run dev`: Start development server with Vite.
- `npm run build`: Compile TypeScript (`tsc -b`) and bundle with Vite (`vite build`). Outputs to `dist/` directory.
- `npm run lint`: Run ESLint on the codebase.
- `npm run preview`: Preview the built app with Vite.

### Build Process
1. Install dependencies: `npm install`
2. Development: `npm run dev` (runs on http://localhost:5173)
3. Build for production:
   - TypeScript checks and compiles using `tsconfig.json` (references `tsconfig.app.json` for app and `tsconfig.node.json` for Vite config).
   - Vite bundles the app with React plugin (`@vitejs/plugin-react`) for JSX/TSX support.
   - Output: Optimized static files in `dist/` (HTML, JS, CSS).
4. Lint: `npm run lint` to ensure code quality.

### Deployment
- Frontend: Deploy `dist/` contents to a static host (e.g., Azure Static Web Apps).
- Infrastructure: Use Bicep files in `deployment/`:
  - `main.bicep`: Main deployment template.
  - `keyvault.bicep`: Key Vault module.
  - `parameters.json`: Deployment parameters.
  Run with Azure CLI: `az deployment group create --resource-group <rg> --template-file deployment/main.bicep --parameters deployment/parameters.json`.

## Project Structure
```
/ (root)
├── src/                 # React source code
├── public/              # Static assets (e.g., vite.svg)
├── deployment/          # Bicep infrastructure templates
├── .gitignore
├── index.html           # App entry HTML
├── package.json         # Dependencies and scripts
├── tsconfig.json        # TS config (app + node)
├── vite.config.ts       # Vite config with React plugin
└── README.md            # This file
```
