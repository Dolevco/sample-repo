@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

param enablePurgeProtection bool = true
param enableSoftDelete bool = true
param publicNetworkAccess string = 'Disabled' // Disable public network access
param networkAcls object = {
  bypass: 'AzureServices'
  defaultAction: 'Deny'
  ipRules: []
  virtualNetworkRules: []
}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    tenantId: tenantId
    accessPolicies: [] // Use Azure RBAC, so no access policies
    sku: {
      name: skuName
      family: 'A'
    }
    enablePurgeProtection: enablePurgeProtection
    enableSoftDelete: enableSoftDelete
    publicNetworkAccess: publicNetworkAccess
    networkAcls: networkAcls
  }
  identity: {
    type: 'SystemAssigned'
  }
}

output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id
