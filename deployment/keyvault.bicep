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
    accessPolicies: [] // Using RBAC, so no access policies
    sku: {
      name: skuName
      family: 'A'
    }
    networkAcls: networkAcls
    publicNetworkAccess: 'Disabled'
    enablePurgeProtection: true
    enableSoftDelete: true
  }
  identity: {
    type: 'SystemAssigned'
  }
}

output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id
