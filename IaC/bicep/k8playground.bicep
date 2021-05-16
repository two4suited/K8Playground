param resourceTags object = {
  Environment: 'Dev'
  Project: 'Playground'
}


resource acr 'Microsoft.ContainerRegistry/registries@2020-11-01-preview' = {
  location: 'westus'
  name: 'k8repo'
  sku: {
   name: 'Basic'
  }
  tags: resourceTags
}
