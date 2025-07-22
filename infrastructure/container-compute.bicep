targetScope = 'resourceGroup'

param location string = 'southafricanorth'
param managedEnvironmentName string = 'ca-env-hello-world'

resource managedEnvironment 'Microsoft.App/managedEnvironments@2025-01-01' = {
  name: managedEnvironmentName
  location: location
}
