targetScope = 'subscription'


@minLength(3)
@maxLength(11)
param namePrefix string = 'sheridan'

param location string = 'westus'

param clusterName string = '${namePrefix}k8playground'

param resourceTags object = {
  Environment: 'Production'
  Project: 'k8Playground'
  Author: 'Brian Sheridan'
}

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01'= {
  location: location
  name: 'k8playground'
  tags: resourceTags
}

module acrModule 'azureregistory.bicep' ={
  name: '${namePrefix}_acr'
  scope:resourceGroup(rg.name)
  params: {
    location: location
    prefix: namePrefix   
    resourceTags: resourceTags
  }
}


