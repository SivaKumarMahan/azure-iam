@description('Custom type for a single Resource Group')
type ResourceGroupParam = {
  resourceGroupName: string
  location: string
}

@description('Array of Resource Group Params')
@export()
type ResourceGroupParams = ResourceGroupParam[]
