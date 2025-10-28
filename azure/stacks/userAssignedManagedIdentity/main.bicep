import {CommonParams} from '../../types/common/types.bicep'
import {RoleDefinitionParams, UserAssignedIdentityParams, RoleAssignmentParams} from '../../types/userAssignedManagedIdentity/types.bicep'

param commonParams CommonParams
param roleDefinitionParams RoleDefinitionParams
param userAssignedIdentityParams UserAssignedIdentityParams
param roleAssignmentParams RoleAssignmentParams

module roleDefinition '../../modules/userAssignedManagedIdentity/roles/definition.bicep' = {
  name: 'roleDef'
  params: {
    roleDefinitionParams: roleDefinitionParams
  }
}

module userAssignedIdentity '../../modules/userAssignedManagedIdentity/identity/userAssigned.bicep' = {
  name: 'uai'
  params: {
    commonParams: commonParams
    userAssignedIdentityParams: userAssignedIdentityParams
  }
}

module roleAssignment '../../modules/userAssignedManagedIdentity/roles/assignment.bicep' = {
  name: 'roleAssign'
  scope: subscription()
  params: {
    roleAssignmentParams: roleAssignmentParams
    principal_id: userAssignedIdentity.outputs.principal_id
    roleDefinitionId: roleDefinition.outputs.roleDefinitionId
  }
}
