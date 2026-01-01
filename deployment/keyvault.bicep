@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

param enablePurgeProtection bool = true
param enableSoftDelete bool = true
param publicNetworkAccess string = 'Disabled' // Disable public network access
param firewallRules array = [] // Allow firewall rules settings
param enableRbacAuthorization bool = true

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    tenantId: tenantId
    accessPolicies: [] // Empty access policies to enforce RBAC
    enablePurgeProtection: enablePurgeProtection
    enableSoftDelete: enableSoftDelete
    publicNetworkAccess: publicNetworkAccess
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: firewallRules
    }
    enableRbacAuthorization: enableRbacAuthorization
  }
  sku: {
    name: skuName
    family: 'A'
  }
}

output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id
