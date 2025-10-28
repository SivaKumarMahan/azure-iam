import {CommonParams} from '../../../types/common/types.bicep'
import {UserAssignedIdentityParams} from '../../../types/userAssignedManagedIdentity/types.bicep'

param commonParams CommonParams
param userAssignedIdentityParams UserAssignedIdentityParams

param location string = 'eastus'

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: userAssignedIdentityParams.identityName
  location: location
  tags: commonParams.tags
}

output principal_id string = userAssignedIdentity.properties.principalId
output client_id string = userAssignedIdentity.properties.clientId

