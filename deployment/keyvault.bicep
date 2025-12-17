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
    accessPolicies: [] // Removed to use Azure RBAC (AZR-000388)
    sku: {
      name: skuName
      family: 'A'
    }
    publicNetworkAccess: 'Disabled' // Disable public network access (CKV_AZURE_189)
    enablePurgeProtection: true // Enable purge protection (CKV_AZURE_110)
    enableSoftDelete: true // Ensure key vault is recoverable (CKV_AZURE_42)
    networkAcls: {
      bypass: 'AzureServices' // Allow trusted Azure services
      defaultAction: 'Deny' // Deny by default
      ipRules: [
        // Add specific IP addresses or ranges here for firewall rules (CKV_AZURE_109, AZR-000355)
      ]
      virtualNetworkRules: [
        // Add virtual network rules here if needed
      ]
    }
  }
}
