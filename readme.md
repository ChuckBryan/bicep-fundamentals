# Common Tasks when running Bicep Scripts
1. Use Bash (I just prefer it over powershell)
2. Make sure az bicep is installed and upgraded:
```bash
az bicep install && az bicep upgrade
```
3. Sign in to Azure
```bash
az login
```
4. Set the default subscription of all of the Azure CLI Command you run in the session:
```bash
az account set --subscription {your subscription ID}
```
5. Set the default resource group for the session
```bash
az group list
az configure --defaults group="<Your Resuource Group>"
```
6. Deploy a Template
```bash
az deployment group create --template-file main.bicep --parameters location=westus3
```
7. Set Variables names for login/passwords that will not be displayed on screen
```bash
read -s -p "Enter the login name: " login
read -s -p "Enter the password: " password
```
and then uses this:
```bash
az deployment group create --template-file main.bicep \
--parameters location=eastus sqlServerAdministratorLogin=login sqlServerAdministratorLoginPassword=password
```