#!/bin/bash

# Variables
RESOURCE_GROUP="terraform-state-rg"
LOCATION="canadacentral"

# Storage accounts names must be globally unique and lowercase, between 3-24 chars, numbers and letters only
STAGING_STORAGE_ACCOUNT="tfstagebackend2025ashok"
DEV_STORAGE_ACCOUNT="tfdevbackend2025ashok"

# Containers to hold tfstate files
CONTAINER_NAME="tfstate"

# Create resource group
echo "Creating resource group: $RESOURCE_GROUP"
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create storage accounts
echo "Creating staging storage account: $STAGING_STORAGE_ACCOUNT"
az storage account create \
  --name $STAGING_STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS \
  --encryption-services blob

echo "Creating dev storage account: $DEV_STORAGE_ACCOUNT"
az storage account create \
  --name $DEV_STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS \
  --encryption-services blob


# Get storage account keys
# STAGING_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP --account-name $STAGING_STORAGE_ACCOUNT --query '[0].value' -o tsv)
# DEV_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP --account-name $DEV_STORAGE_ACCOUNT --query '[0].value' -o tsv)

# Create containers for tfstate files
echo "Creating container $CONTAINER_NAME in $STAGING_STORAGE_ACCOUNT"
az storage container create --name $CONTAINER_NAME --account-name $STAGING_STORAGE_ACCOUNT 

echo "Creating container $CONTAINER_NAME in $DEV_STORAGE_ACCOUNT"
az storage container create --name $CONTAINER_NAME --account-name $DEV_STORAGE_ACCOUNT

echo "Setup complete!"

echo "Storage account and container details:"
echo "Staging Account: $STAGING_STORAGE_ACCOUNT, Container: $CONTAINER_NAME"
echo "Dev Account: $DEV_STORAGE_ACCOUNT, Container: $CONTAINER_NAME"