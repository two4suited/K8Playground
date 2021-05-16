


@description('Specifies the Azure location where the container registry should be created.')
param location string

@description('What to prefix all the resources with')
param prefix string

@description('Specified the list of tags')
param resourceTags object




@minLength(5)
@maxLength(50)
@description('Specifies the name of the azure container registry.')
param acrName string = '${prefix}k8playgroundrepo' // must be globally unique

@description('Enable admin user that have push / pull permission to the registry.')
param acrAdminUserEnabled bool = false


@allowed([
  'Basic'
  'Standard'
  'Premium'
])
@description('Tier of your Azure Container Registry.')
param acrSku string = 'Basic'

// azure container registry
resource acr 'Microsoft.ContainerRegistry/registries@2019-12-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: acrAdminUserEnabled
  }
  tags: resourceTags
}

output acrLoginServer string = acr.properties.loginServer
