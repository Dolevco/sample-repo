targetScope = 'subscription'

@description('Specifies the location for resources.')
param location string = 'eastus'

@description('Specifies the name of the resource group.')
param resourceGroupName string

@description('Specifies the name of the key vault.')
param keyVaultName string

@description('Role assignments for the vault')
param roleAssignments array

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
    roleAssignments: roleAssignments
  }
}

output keyVaultName string = keyVault.outputs.keyVaultName
output keyVaultId string = keyVault.outputs.keyVaultId