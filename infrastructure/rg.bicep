targetScope = 'subscription'

param resourceGroupName string = 'rg-hello-world-za'
param location string = 'southafricanorth'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}
