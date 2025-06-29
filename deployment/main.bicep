targetScope = 'subscription'

@description('Specifies the location for resources.')
param location string = 'eastus'

@description('Specifies the name of the resource group.')
param resourceGroupName string

@description('Specifies the name of the key vault.')
param keyVaultName string

@description('Specifies the object ID of the user or service principal.')
param objectId string

// Create Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

// Deploy Key Vault
module keyVault 'keyvault.bicep' = {
  scope: rg
  name: 'keyVaultDeployment'
  params: {
    keyVaultName: keyVaultName
    location: location
    objectId: objectId
  }
}

output keyVaultName string = keyVault.outputs.keyVaultName
output keyVaultId string = keyVault.outputs.keyVaultId
