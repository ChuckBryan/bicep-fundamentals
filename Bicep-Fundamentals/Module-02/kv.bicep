/*
When running from a bash script, you can use the following code to prompt for the login and password values:

keyVaultName='YOUR-KEY-VAULT-NAME'
read -s -p "Enter the login name: " login
read -s -p "Enter the password: " password

this is how you would then pass to this bicep script:
az deployment group create \
 --resource-group $resourceGroup \
  --template-file $templateFile \
  --parameters keyVaultName=$keyVaultName \
    sqlServerAdministratorLogin=$login \
    sqlServerAdministratorPassword=$password

*/

param keyVaultName string
@secure()
param sqlServerAdministratorLogin string
@secure()
param sqlServerAdministratorPassword string

param location string = 'eastus'

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: []
  }
}

resource loginSecret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  parent: kv
  name: 'sqlServerAdministratorLogin'
  properties: {
    value: sqlServerAdministratorLogin
  }
}

resource passwordSecret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  parent: kv
  name: 'sqlServerAdministratorPassword'
  properties: {
    value: sqlServerAdministratorPassword
  }
}

// return the key vault resource id
output keyVaultResourceId string = kv.id
