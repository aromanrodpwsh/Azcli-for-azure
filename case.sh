var=$(az group list --query "[? contains(name, '$resourceGroup')].name" --output tsv)
case $resourceGroup in
$var)
echo The $resourceGroup resource group already exists.;;
*)
az group create --name $resourceGroup --location "$location";;
esac