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

@description('Specifies whether the key vault is a standard vault or a premium vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

@description('Enable soft delete for Key Vault')
param enableSoftDelete bool = true

@description('Enable purge protection for Key Vault')
param enablePurgeProtection bool = true

@description('Enable RBAC authorization for Key Vault')
param enableRbacAuthorization bool = true

@description('Key Vault network ACL configuration')
param networkAcls object = {
  defaultAction: 'Deny'
  bypass: 'AzureServices'
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
    enableRbacAuthorization: enableRbacAuthorization
    enableSoftDelete: enableSoftDelete
    enablePurgeProtection: enablePurgeProtection
    publicNetworkAccess: 'Disabled'
    networkAcls: networkAcls
    sku: {
      name: skuName
      family: 'A'
    }
  }
}

output keyVaultName string = keyVault.name
output keyVaultId string = keyVault.id