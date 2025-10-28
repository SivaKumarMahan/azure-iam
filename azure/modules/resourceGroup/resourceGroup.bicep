@description('Array of resource group parameters')
param resourceGroupParams array

targetScope = 'subscription'

resource resourceGroups 'Microsoft.Resources/resourceGroups@2021-04-01' = [for rg in resourceGroupParams: {
  name: rg.resourceGroupName
  location: rg.location
}]
