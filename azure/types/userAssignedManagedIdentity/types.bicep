@description('Custom type for custom role definition')
@export()
type RoleDefinitionParams = {
  roleDefinitionName: string
  roleName: string
  roleDescription: string
  permissions: object
  subscriptionId: string
  type: string
  assignableScopes: array
}

@description('Custom type for Managed Identity Deployment')
@export()
type UserAssignedIdentityParams = {
  identityName: string
}

@description('Custom type for Role Assignment')
@export()
type RoleAssignmentParams = {
  roleAssign: string
  principalType: string
  subscriptionid: string
}
