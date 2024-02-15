#!/usr/bin/env bash
#if it is a one time valu, consider piping
az vm list --query "[?powerState=='VM running'].name" --output tsv | grep my_vm

for vmList in $(az vm list --resource-group MyResourceGroup --show-details --query "[?powerState=='VM running'].id"   --output tsv); do
    echo stopping $vmList
    az vm stop --ids $vmList
    if [ $? -ne 0 ]; then
        echo "Failed to stop $vmList"
        exit 1
    fi
    echo $vmList stopped
done

az vm list --resource-group MyResourceGroup --show-details --query "[?powerState=='VM stopped'].id" --output tsv | xargs -I {} -P 10 az vm start --ids "{}"

az vm list --resource-group MyResourceGroup --show-details --query "[?powerState=='VM stopped'].id" --output tsv | az vm start --ids @-