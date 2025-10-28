import {CommonParams} from '../../types/common/types.bicep'
import {RoleAssignmentParams} from '../../types/userGroupPredefinedRole/types.bicep'

param commonParams CommonParams
param roleAssignmentParams RoleAssignmentParams

module roleAssignment '../../modules/userGroupPredefinedRole/assignment.bicep' = {
  name: 'groupRoleAssign'
  params: {
    roleAssignmentParams: roleAssignmentParams
    principal_id: roleAssignmentParams.principal_id
    roleDefinitionId: roleAssignmentParams.roleDefinitionId
  }
}
