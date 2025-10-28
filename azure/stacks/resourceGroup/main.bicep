import {ResourceGroupParams} from '../../types/resourceGroup/types.bicep'

param resourceGroupParams ResourceGroupParams

targetScope = 'subscription'

module resourceGroups '../../modules/resourceGroup/resourceGroup.bicep' = {
  name: 'resourceGroups'
  params: {
    resourceGroupParams: resourceGroupParams
  }
}
