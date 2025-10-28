using '../../../stacks/userAssignedManagedIdentity/main.bicep'
extends '../../base/base.bicepparam'

param roleDefinitionParams = {
  roleDefinitionName: 'role-def-mi-devopsMi'
  roleName: 'role-def-mi-devopsMi'
  roleDescription: 'Custom role to allow full access to storage account and key vault within resource group'
  type: 'CustomRole'
  permissions: {
    actions: [
          'Microsoft.Storage/*'
          'Microsoft.KeyVault/*'
    ]
    notActions: [
      'Microsoft.Subscription/cancel/action'
      'Microsoft.Subscription/enable/action'
    ]
  }
  subscriptionId: 'subscription-id'
  assignableScopes: [
      '/subscriptions/subscription-id/resourceGroups/azure-training'
  ]
}

param userAssignedIdentityParams = {
  identityName: 'uami'
}

param roleAssignmentParams = {
  roleAssign: 'role-assignment-mi-devopsMi'
  subscriptionid : 'subscription-id'
  principalType: 'ServicePrincipal'
}
