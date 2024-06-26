@description('The Azure region into which the reousrces should be deployed.')
param location string = 'eastus'

@description('The name of the App Service app.')
param appServiceAppName string = 'toy-${uniqueString(resourceGroup().id)}'

@description('The name of the App Service plan SKU.')
param appServicePlanSkuName string = 'F1'

@description('Whether or not to deploy the CDN.')
param deployCdn bool = true

var appServicePlanName = 'toy-product-launch-plan'

module app 'modules/app.bicep' = {
  name: 'toy-launch-app'
  params: {
    appServiceAppName: appServiceAppName
    appServicePlanName: appServicePlanName
    appServicePlanSkuName: appServicePlanSkuName
    location: location
  }
}

module cdn 'modules/cdn.bicep' = if (deployCdn) {
  name: 'toy-launch-cdn'
  params: {
    httpsOnly: true
    originHostName:app.outputs.appServiceAppHostName
  }
}

@description('The host name to use to access the website.')
output websiteHostname string = deployCdn ? cdn.outputs.endpointHostName : app.outputs.appServiceAppHostName


