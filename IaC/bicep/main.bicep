@minLength(3)
@maxLength(11)
param namePrefix string = 'sheridan'
param location string = resourceGroup().location

module acrModule 'azureregistory.bicep' ={
  name: '${namePrefix}_acr'
  params: {
    location: location
    prefix: namePrefix
  }
}
