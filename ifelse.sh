if [ $resourceGroup != '' ]; then
   echo $resourceGroup
else
   resourceGroup="msdocs-learn-bash-$randomIdentifier"
fi

if [ $(az group exists --name $resourceGroup) = false ]; then 
   az group create --name $resourceGroup --location "$location" 
else
   echo $resourceGroup
fi

if [ $(az group exists --name $resourceGroup) = true ]; then 
   az group delete --name $resourceGroup -y # --no-wait
else
   echo The $resourceGroup resource group does not exist
fi

az group list --output tsv | grep $resourceGroup -q || az group create --name $resourceGroup --location "$location"