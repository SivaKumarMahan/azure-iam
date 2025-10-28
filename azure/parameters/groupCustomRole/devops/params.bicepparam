using '../../../stacks/groupCustomRole/main.bicep'
extends '../../base/base.bicepparam'

param roleDefinitionParams = {
  roleDefinitionName: 'role-def-group-devops'
  roleName: 'role-def-group-devops'
  roleDescription: 'Custom role to allow full access to storage account and key vault within resource group'
  type: 'CustomRole'
  permissions: {
    actions: [
      'Microsoft.Resources/subscriptions/resourceGroups/read'
      'Microsoft.Storage/*'
      'Microsoft.KeyVault/*'
      'Microsoft.Network/virtualNetworks/*'
      'Microsoft.Compute/virtualMachines/*'
      'Microsoft.Resources/deployments/*'
      'Microsoft.Resources/subscriptions/resourceGroups/resources/read'
      'Microsoft.Resources/deploymentStacks/*'
    ]
    notActions: [
    ]
  }
  subscriptionId: 'subscription-id'
  assignableScopes: [
      '/subscriptions/subscription-id/resourceGroups/DevOps_resources'
  ]
}

param roleAssignmentParams = {
  roleAssignName : 'role-assignment-group-devops'
  principalType: 'Group'
  principal_id: '*********'   //Object id of the group
}
