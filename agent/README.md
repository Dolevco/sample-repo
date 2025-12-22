# Project Overview

This repository is a React application built with TypeScript and Vite, featuring ESLint for code quality and linting. It includes Azure deployment templates specifically for Key Vault management located in the `deployment/` directory.

## Repository Structure

- `src/`: Contains the main application code following a simple React app structure.
- `deployment/`: Contains Azure deployment templates for Key Vault.
- `agent/`: Contains this README.md file describing the repository.

## Technologies Used

- **React**: Frontend library for building user interfaces.
- **TypeScript**: Superset of JavaScript providing static typing.
- **Vite**: Build tool and development server for fast and optimized builds.
- **ESLint**: Linting tool to maintain code quality and consistency.

## Setup and Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Run the development server:
   ```bash
   npm run dev
   ```

## Building the Project

To build the project for production, run:

```bash
npm run build
```

The output will be in the `dist/` directory.

## Linting

To check and fix linting issues, use:

```bash
npm run lint
```

## Azure Deployment Templates

The `deployment/` directory contains ARM templates for deploying Azure Key Vault resources. These templates can be used to automate the provisioning and configuration of Key Vault in your Azure environment.

## Notes

- Ensure you have Node.js and npm installed to run and build the project.
- Customize the Azure deployment templates as needed for your environment.

## Contact

For any questions or issues, please contact the repository maintainer.
