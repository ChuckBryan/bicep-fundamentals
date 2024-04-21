# Common Tasks when running Bicep Scripts
This is the output from taking the Bicep Training from learn.microsoft.com: https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/

I completed the fundamentals and will probably skip intermediate and advanced and jump over to deploying with azure devops: https://learn.microsoft.com/en-us/training/paths/bicep-azure-pipelines/

## My Check List
- [x] Bicep Fundaments
- [ ] Deploy Azure resources by using Bicep and Azure Pipelines

## Notes
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