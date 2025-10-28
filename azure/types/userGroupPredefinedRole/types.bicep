@description('Custom type for Role Assignment')
@export()
type RoleAssignmentParams = {
  roleAssignName: string
  principalType: string
  principal_id: string
  scope: string
  roleDefinitionId: string
}
