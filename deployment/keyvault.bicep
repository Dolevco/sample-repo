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
    // Network access: disable public access and restrict via network ACLs (CKV_AZURE_189, AZR-000355, CKV_AZURE_109)
    publicNetworkAccess: 'Disabled'
    networkAcls: {
      defaultAction: 'Deny'
      // Allow bypass for trusted Azure services if needed (adjust per environment)
      bypass: 'AzureServices'
      // Add allowed IPs and Virtual Network rules below (placeholders). Replace with your allowed IPs/VNet IDs.
      ipRules: [
        // example: {
        //   value: '1.2.3.4'
        // }
      ]
      virtualNetworkRules: [
        // example: {
        //   id: '/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Network/virtualNetworks/<vnet>/subnets/<subnet>'
        // }
      ]
    }

    // Data protection: enable soft-delete and purge protection (CKV_AZURE_42, CKV_AZURE_110)
    enableSoftDelete: true
    enablePurgeProtection: true

    // Access model: remove inline accessPolicies to migrate to Azure RBAC (AZR-000388).
    // Keep accessPolicies empty and manage access via Azure RBAC role assignments.
    // NOTE: Purge protection is irreversible once enabled. See deployment/README.md for details.
    accessPolicies: []

    sku: {
      name: skuName
      family: 'A'
    }
  }
}

output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id
