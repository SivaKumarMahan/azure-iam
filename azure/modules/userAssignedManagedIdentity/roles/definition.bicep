import {RoleDefinitionParams} from '../../../types/userAssignedManagedIdentity/types.bicep'

param roleDefinitionParams RoleDefinitionParams

resource roleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(roleDefinitionParams.subscriptionId, roleDefinitionParams.roleDefinitionName)
  properties: {
    roleName: roleDefinitionParams.roleName
    description: roleDefinitionParams.roleDescription
    type: roleDefinitionParams.type
    permissions: [
      {
        actions: roleDefinitionParams.permissions.actions
        notActions: roleDefinitionParams.permissions.notActions
      }
    ]
    assignableScopes: roleDefinitionParams.assignableScopes
  }
}

output role_definition_name string = roleDefinition.name
output roleDefinitionId string = roleDefinition.id
