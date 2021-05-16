param resourceTags object = {
  Environment: 'Production'
  Project: 'k8Playground'
  Author: 'Brian Sheridan'
}


resource acr 'Microsoft.ContainerRegistry/registries@2020-11-01-preview' = {
  location: 'westus'
  name: 'sheridank8Repo'
  sku: {
   name: 'Basic'
  }
  tags: resourceTags
}
