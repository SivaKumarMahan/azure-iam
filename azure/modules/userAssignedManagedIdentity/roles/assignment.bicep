import {RoleAssignmentParams} from '../../../types/userAssignedManagedIdentity/types.bicep'

param roleAssignmentParams RoleAssignmentParams
param principal_id string
param roleDefinitionId string

targetScope = 'subscription'

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().id, roleAssignmentParams.roleAssign)
  scope: subscription()
  properties: {
    roleDefinitionId: roleDefinitionId
    principalId: principal_id
    principalType: roleAssignmentParams.principalType
  }
}
