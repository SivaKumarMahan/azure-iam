import {RoleAssignmentParams} from '../../types/userGroupPredefinedRole/types.bicep'

param roleAssignmentParams RoleAssignmentParams
param principal_id string
param roleDefinitionId string

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, roleAssignmentParams.roleAssignName)
  scope: resourceGroup()
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
    principalId: principal_id
    principalType: roleAssignmentParams.principalType
  }
}

output roleDefinitionId string = roleDefinitionId
