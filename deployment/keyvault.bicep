param keyVaultName string
param location string = resourceGroup().location

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    publicNetworkAccess: 'Disabled'
    enablePurgeProtection: true
    enableSoftDelete: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: [
        {
          value: 'YOUR_FIREWALL_IP_RANGE'
        }
      ]
      virtualNetworkRules: []
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(keyVault.id, 'keyVaultAccess')
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b86a8fe4-44ce-4948-aee5-eccb2c155cd7') // Key Vault Contributor
    principalId: keyVault.identity.principalId
    principalType: 'ServicePrincipal'
    scope: keyVault
  }
  dependsOn: [keyVault]
}