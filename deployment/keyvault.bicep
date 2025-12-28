@description('Specifies the name of the key vault.')
param keyVaultName string

@description('Specifies the Azure location where the key vault should be created.')
param location string = resourceGroup().location

@description('Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.')
param enabledForDeployment bool = false

@description('Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.')
param enabledForDiskEncryption bool = false

@description('Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault.')
param enabledForTemplateDeployment bool = false

@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.')
param tenantId string = subscription().tenantId

@description('Specifies the object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault.')
param objectId string

@description('Specifies the permissions to keys in the vault.')
param keysPermissions array = [
  'get'
  'list'
  'create'
  'delete'
  'update'
]

@description('Specifies the permissions to secrets in the vault.')
param secretsPermissions array = [
  'get'
  'list'
  'set'
  'delete'
]

@description('Specifies whether the key vault is a standard vault or a premium vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    tenantId: tenantId
    publicNetworkAccess: 'Disabled'
    enableSoftDelete: true
    enablePurgeProtection: true
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      ipRules: []
      bicepAccess: true
    }
    sku: {
      name: skuName
      family: 'A'
    }
  }
}

resource keyVaultRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVault.id, subscription().id, 'Key Vault Crypto Officer')
  scope: keyVault
  properties: {
    roleDefinitionId: subscription().id + '/providers/Microsoft.Authorization/roleDefinitions/14b46e9e-c2b5-41b5-931c-3f1626cb9294'
    principalId: keyVault.identity.principalId
    principalType: 'ServicePrincipal'
  }
}

output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id