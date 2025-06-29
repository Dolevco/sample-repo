# Azure Key Vault Deployment

This folder contains Bicep templates for deploying an Azure Key Vault.

## Files Structure

- `main.bicep` - Main deployment template that creates the resource group and calls the Key Vault module
- `keyvault.bicep` - Key Vault module template with all the vault configurations
- `parameters.json` - Parameters file for the deployment

## Prerequisites

1. Azure CLI installed
2. Azure subscription
3. User or Service Principal with required permissions

## Deployment Steps

1. Log in to Azure:
```bash
az login
```

2. Get your Object ID (for a user):
```bash
az ad signed-in-user show --query id -o tsv
```

3. Update the `parameters.json` file with:
   - Your desired resource group name
   - Key Vault name (must be globally unique)
   - Your Object ID from step 2

4. Deploy the template:
```bash
az deployment sub create \
  --location eastus \
  --template-file main.bicep \
  --parameters @parameters.json
```

## Security Considerations

- The Key Vault is deployed with default network access rules
- Access policies are configured using the provided Object ID
- Modify the `keyvault.bicep` template to add additional security features like:
  - Private Endpoints
  - Network ACLs
  - Additional access policies