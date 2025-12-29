param location string = resourceGroup().location

param keyVaultName string

param skuName string = 'standard'

param tenantId string

param softDeleteRetentionInDays int = 90

param enablePurgeProtection bool = true

param objectId string

param keysPermissions array

param secretsPermissions array

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: skuName
    }
    tenantId: tenantId
    enableRbacAuthorization: true
    publicNetworkAccess: 'Disabled'
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      ipRules: []
    }
    enableSoftDelete: true
    softDeleteRetentionInDays: softDeleteRetentionInDays
    purgeProtectionEnabled: enablePurgeProtection
  }
}

output keyVaultId string = keyVault.id

output keyVaultName string = keyVault.name