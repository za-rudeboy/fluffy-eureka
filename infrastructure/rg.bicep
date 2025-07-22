targetScope = 'subscription'

param resourceGroupName string = 'rg-hello-world-za'
param location string = 'southafricanorth'

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
  tags: {
    environment: 'non-production'
  }
}
