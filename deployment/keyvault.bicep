@description('Specifies the name of the key vault.')
param keyVaultName string

@description('Specifies the Azure location where the key vault should be created.')
param location string = resourceGroup().location

@description('Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.')
param enabledForDeployment bool = false

@description('Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the key vault and unwrap keys.')
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

@description('List of IP CIDR ranges to allow through the Key Vault firewall. Example: ["1.2.3.4/32"]').
param keyVaultIpRules array = []

@description('List of virtual network rule objects for Key Vault firewall. Each item should be an object with an id property referencing the subnet resource id.')
param keyVaultVirtualNetworkRules array = []

@description('Enable purge protection for the Key Vault. This requires organizational approval. Default is false (disabled).')
param enablePurgeProtection bool = false

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    tenantId: tenantId
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
    // Disable public network access to remediate CKV_AZURE_189
    publicNetworkAccess: 'Disabled'

    // Configure firewall rules and default deny to remediate AZR-000355 / CKV_AZURE_109
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      ipRules: [for ip in keyVaultIpRules: {
        value: ip
      }]
      virtualNetworkRules: keyVaultVirtualNetworkRules
    }

    // Enable soft-delete to remediate CKV_AZURE_42
    enableSoftDelete: true

    // Purge protection is disabled by default and must be enabled only with approvals (CKV_AZURE_110)
    enablePurgeProtection: enablePurgeProtection
  }
}

output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id
