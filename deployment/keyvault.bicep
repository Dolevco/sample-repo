@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

param keyVaultName string
param location string
param tenantId string
param objectId string
param keysPermissions array
param secretsPermissions array
param enabledForDeployment bool = false
param enabledForDiskEncryption bool = false
param enabledForTemplateDeployment bool = false
param publicNetworkAccess string = 'Disabled' // Disable public network access
param enablePurgeProtection bool = true // Enable purge protection
param enableSoftDelete bool = true // Ensure recoverability
param firewallRules array = [] // Allow firewall rules

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    tenantId: tenantId
    accessPolicies: [] // Use Azure RBAC, so no access policies
    publicNetworkAccess: publicNetworkAccess
    enablePurgeProtection: enablePurgeProtection
    enableSoftDelete: enableSoftDelete
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: firewallRules
    }
  }
  sku: {
    name: skuName
    family: 'A'
  }
  identity: {
    type: 'SystemAssigned'
  }
}

output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id
