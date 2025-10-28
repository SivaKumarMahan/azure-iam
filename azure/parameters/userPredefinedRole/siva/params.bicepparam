using '../../../stacks/userPredefinedRole/main.bicep'
extends '../../base/base.bicepparam'

param roleAssignmentParams = {
  roleAssignName: 'role-assignment-user-siva'
  principalType: 'User'
  principal_id: '******************'   // Object ID of the user
  scope: '/subscriptions/subscription-id/resourceGroups/azure-training'
  roleDefinitionId: 'acdd72a7-3385-48ef-bd42-f606fba81ae7' //Reader
}
