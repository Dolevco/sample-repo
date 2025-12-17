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
    publicNetworkAccess: 'Disabled'
    enablePurgeProtection: true
    enableSoftDelete: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: [
        // Add specific allowed IP addresses here
      ]
      virtualNetworkRules: [
        // Add specific virtual network rules here
      ]
    }
    enableRbacAuthorization: true
  }
}

output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id
