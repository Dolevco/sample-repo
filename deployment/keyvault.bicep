@description('Specifies the name of the key vault.')
param keyVaultName string

@description('Specifies the Azure location where the key vault should be created.')
param location string = resourceGroup().location

@description('Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.')
param enabledForDeployment bool = false

@description('Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.')
param enabledForDiskEncryption bool = false

@description('Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault.')
param enabledForTemplateDeployment bool = false

@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.')
param tenantId string = subscription().tenantId

@description('Specifies the object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault.')
param objectId string

@description('Specifies the permissions to keys in the vault.')
param keysPermissions array = [
  'get'
  'list'
  'create'
  'delete'
  'update'
]

@description('Specifies the permissions to secrets in the vault.')
param secretsPermissions array = [
  'get'
  'list'
  'set'
  'delete'
]

@description('Specifies whether the key vault is a standard vault or a premium vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    tenantId: tenantId

    // MDC: d9be0ff8-3eb0-4348-82f6-c1e735f85983 - CKV_AZURE_189: Disable public network access
    // Disables public access to the vault; allow access via network rules only
    publicNetworkAccess: 'Disabled'

    // MDC: d9be0ff8-3eb0-4348-82f6-c1e735f85983 - AZR-000355 / CKV_AZURE_109: network ACLs and firewall rules
    // Default deny to enforce allow-listing of IPs/VNETs. ipRules and virtualNetworkRules are empty by default; update as required.
    networkAcls: {
      defaultAction: 'Deny'
      // Keep AzureServices bypass if needed for platform services; adjust if stricter posture required
      bypass: 'AzureServices'
      ipRules: []
      virtualNetworkRules: []
    }

    // MDC: d9be0ff8-3eb0-4348-82f6-c1e735f85983 - CKV_AZURE_42: Enable soft-delete to retain deleted vault objects
    enableSoftDelete: true

    // MDC: d9be0ff8-3eb0-4348-82f6-c1e735f85983 - CKV_AZURE_110: Enable purge protection
    // NOTE: Purge protection is irreversible once enabled. Require stakeholder approval before enabling in production.
    enablePurgeProtection: true

    accessPolicies: [
      {
        objectId: objectId
        tenantId: tenantId
        permissions: {
          keys: keysPermissions
          secrets: secretsPermissions
        }
      }
    ]
    sku: {
      name: skuName
      family: 'A'
    }
  }
}

// Note: AZR-000388 (RBAC migration) is out of scope for this IaC change; RBAC migration should be planned and executed separately.

output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id
