import {RoleAssignmentParams} from '../../../types/userGroupCustomRole/types.bicep'

param roleAssignmentParams RoleAssignmentParams
param principal_id string
param roleDefinitionId string

resource RoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, roleAssignmentParams.roleAssignName)
  scope: resourceGroup()
  properties: {
    roleDefinitionId: roleDefinitionId
    principalId: principal_id
    principalType: roleAssignmentParams.principalType
  }
}
