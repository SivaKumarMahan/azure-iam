using '../../../stacks/userCustomRole/main.bicep'
extends '../../base/base.bicepparam'

param roleDefinitionParams = {
  roleDefinitionName: 'role-def-user-siva'
  roleName: 'role-def-user-siva'
  roleDescription: 'Custom role to allow full access to resources within resource group'
  type: 'CustomRole'
  permissions: {
    actions: [
      'Microsoft.Resources/subscriptions/resourceGroups/read'
      'Microsoft.Storage/*'
      'Microsoft.KeyVault/*'
      'Microsoft.Network/virtualNetworks/*'
      'Microsoft.Compute/virtualMachines/*'
      'Microsoft.Resources/deployments/validate/action'
      'Microsoft.Resources/deployments/write'
      'Microsoft.Resources/deployments/read'
    ]
    notActions: [
    ]
  }
  subscriptionId: 'subscription-id'
  assignableScopes: [
      '/subscriptions/subscription-id/resourceGroups/azure-training'
  ]
}

param roleAssignmentParams = {
  roleAssignName : 'role-assignment-user-sivaNallabothula'
  principalType: 'User'
  principal_id: '******************'      //Object Id of the User
}
