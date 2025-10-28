import {CommonParams} from '../../types/common/types.bicep'
import {RoleDefinitionParams, RoleAssignmentParams} from '../../types/userGroupCustomRole/types.bicep'

param commonParams CommonParams
param roleDefinitionParams RoleDefinitionParams
param roleAssignmentParams RoleAssignmentParams

module roleDefinition '../../modules/userGroupCustomRole/roles/definition.bicep' = {
  name: 'roleDef'
  params: {
    roleDefinitionParams: roleDefinitionParams
  }
}

module roleAssignment '../../modules/userGroupCustomRole/roles/assignment.bicep' = {
  name: 'roleAssign'
  params: {
    roleAssignmentParams: roleAssignmentParams
    principal_id: roleAssignmentParams.principal_id
    roleDefinitionId: roleDefinition.outputs.roleDefinitionId
  }
}
