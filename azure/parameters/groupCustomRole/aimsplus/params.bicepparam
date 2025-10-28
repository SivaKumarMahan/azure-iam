using '../../../stacks/groupCustomRole/main.bicep'
extends '../../base/base.bicepparam'

param roleDefinitionParams = {
  roleDefinitionName: 'role-def-group-test'
  roleName: 'role-def-group-test'
  roleDescription: 'Custom role to allow full access to storage account and key vault within resource group'
  type: 'CustomRole'
  permissions: {
    actions: [
          'Microsoft.Storage/*'
          'Microsoft.KeyVault/*'
          'Microsoft.Network/virtualNetworks/*'
          'Microsoft.Compute/virtualMachines/*'
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
  roleAssignName : 'role-assignment-group-test'
  principalType: 'Group'
  principal_id: '*****'   //Object id of the group
}
