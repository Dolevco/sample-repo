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

The Key Vault template has been hardened to follow recommended security controls. Key notes:

- Public network access is disabled by default. Access is restricted via network ACLs (defaultAction: Deny).
- IP rules and Virtual Network rules must be populated before deployment if you need to allow specific client IPs or VNets. Edit `deployment/keyvault.bicep` and populate the `ipRules` and `virtualNetworkRules` sections with allowed values.
- Soft-delete is enabled to ensure recoverability of deleted vault and objects.
- Purge protection is enabled and is irreversible once set. If you enable purge protection, you will not be able to permanently delete (purge) the vault or its objects for the lifetime of the subscription/tenant settings. Confirm this is acceptable before enabling in production.

RBAC migration guidance (moving from accessPolicies to Azure RBAC):
- The template minimizes/clears `accessPolicies` to encourage use of Azure RBAC for Key Vault data plane access.
- To migrate:
  1. Identify all principals currently in `accessPolicies` and the permissions they require.
  2. Assign the appropriate Azure Key Vault data plane roles (for example: Key Vault Secrets User, Key Vault Secrets Officer, Key Vault Administrator) to those principals at the vault scope via `az role assignment create` or via the portal.
  3. Once RBAC roles are assigned and validated, remove entries from `accessPolicies` in the template.

Notes:
- Purge protection is irreversible — you must coordinate with security/operations before enabling in production.
- When restricting network access, ensure any automated services, CI/CD agents, or management IPs are added to `ipRules` or allowed via virtual network rules, otherwise deployment or runtime access may break.

## Hardening change

The Key Vault template (`deployment/keyvault.bicep`) was updated and hardened in branch `fix/iac/keyvault-hardening` to:
- Disable public network access
- Set networkAcls defaultAction to 'Deny' (and provide placeholders for approved IPs/VNets)
- Enable soft-delete and purge protection
- Clear `accessPolicies` to encourage Azure RBAC for data plane access

Refer to the PR for mapping to MDC findings and verification steps.
