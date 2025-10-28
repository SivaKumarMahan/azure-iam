using '../../../stacks/resourceGroup/main.bicep'

param resourceGroupParams = [
  {
    resourceGroupName: 'test-rg-eastus'
    location: 'eastus'
  }
  {
    resourceGroupName: 'test-rg-centralus'
    location: 'centralus'
  }
  {
    resourceGroupName: 'test-rg-westus'
    location: 'westus'
  }
]
