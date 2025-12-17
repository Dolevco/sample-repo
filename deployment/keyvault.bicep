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
    publicNetworkAccess: 'Disabled' // Disable public network access (CKV_AZURE_189)
    enablePurgeProtection: true // Enable purge protection (CKV_AZURE_110)
    enableSoftDelete: true // Ensure key vault is recoverable (CKV_AZURE_42)
    networkAcls: { // Configure Azure Key Vault firewall and allow firewall rules (CKV_AZURE_109, AZR-000355)
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: ipRules // Expecting ipRules param to be defined elsewhere
      virtualNetworkRules: virtualNetworkRules // Expecting virtualNetworkRules param to be defined elsewhere
    }
    enableRbacAuthorization: true // Use Azure role-based access control (AZR-000388)
  }
}

output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id
