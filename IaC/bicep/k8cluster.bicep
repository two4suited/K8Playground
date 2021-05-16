@description('The name of the Managed Cluster resource.')
param clusterName string
 
@description('The location of the Managed Cluster resource.')
param location string = resourceGroup().location
 
@description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string

@description('Specified the list of tags')
param resourceTags object
 
@minValue(0)
@maxValue(1023)
@description('Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
param osDiskSizeGB int = 0
 
@minValue(1)
@maxValue(50)
@description('The number of nodes for the cluster.')
param agentCount int = 1
 
@description('The size of the Virtual Machine. Currently the cheapest is Standard_B2s: https://azureprice.net/?currency=AUD®ion=eastus2')
param agentVMSize string = 'Standard_B2s'
 
@description('User name for the Linux Virtual Machines.')
param linuxAdminUsername string
 
@description('Configure all linux machines with the SSH RSA public key string. Your key should include three parts, for example \'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm\'')
param sshRSAPublicKey string
 
@allowed([
  'Linux'
])
@description('The type of operating system.')
param osType string = 'Linux'
 
resource clusterName_resource 'Microsoft.ContainerService/managedClusters@2020-03-01' = {
  name: clusterName
  location: location
  properties: {
    dnsPrefix: dnsPrefix
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: osDiskSizeGB
        count: agentCount
        vmSize: agentVMSize
        osType: osType
        type: 'VirtualMachineScaleSets'
        mode: 'System' // https://github.com/Azure/AKS/issues/1568#issuecomment-619642862
      }
    ]
    linuxProfile: {
      adminUsername: linuxAdminUsername
      ssh: {
        publicKeys: [
          {
            keyData: sshRSAPublicKey
          }
        ]
      }
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}
 
output controlPlaneFQDN string = reference(clusterName).fqdn
