#!/bin/bash
set -x

# -----------------------------
# Variables (usually from Azure DevOps variable groups)
# -----------------------------
RESOURCE_GROUP=${RESOURCE_GROUP}
LOCATION=${LOCATION}
ACCESS_RESOURCE_IDENTIFIER=${ACCESS_RESOURCE_IDENTIFIER}
STACK_NAME=${STACK_NAME}
DENY_SETTINGS_MODE=${DENY_SETTINGS_MODE}
ACTION_ON_UNMANAGED=${ACTION_ON_UNMANAGED}

# Define Bicep File Paths Based on Resource Type
BICEP_FILE_PATH="./azureiam/azure/stacks/$STACK_NAME/main.bicep"
PARAMS_FILE_PATH="./azureiam/azure/parameters/$STACK_NAME/$ACCESS_RESOURCE_IDENTIFIER/params.bicepparam"

# -----------------------------
# Print Variables
# -----------------------------

echo "Resource Group: $RESOURCE_GROUP"
echo "Location: $LOCATION"
echo "Access Resource Identifier: $ACCESS_RESOURCE_IDENTIFIER"
echo "Bicep File: $BICEP_FILE_PATH"
echo "Parameters File: $PARAMS_FILE_PATH"
echo "Deny Settings Mode: $DENY_SETTINGS_MODE"
echo "Action On Unmanage: $ACTION_ON_UNMANAGED"

# -----------------------------
# Usage Function
# -----------------------------
usage() {
  echo "Usage: $0 [option]"
  echo "  -rw    To preview the deploying Resource Group stack"
  echo "  -rc    To deploy resource group bicep stack"
  echo "  -rd    To delete resource group bicep stack"
  echo "  -bw    To preview the deploying MI, Users, Groups stack"
  echo "  -bc    To deploy MI, Users, Groups bicep stack"
  echo "  -bd    To delete MI, Users, Groups bicep stack"
  exit 1
}

# -----------------------------
# To fix bicep issue
# -----------------------------
bicep_fix() {
  echo "To fix bicep issue"
    az bicep version
    az bicep uninstall
    az config set bicep.use_binary_from_path=false
    az bicep install
    az bicep version
}

# -----------------------------
# What-if Function for Resource Group
# -----------------------------
rg_what_if() {
  echo "To see planned changes in $STACK_NAME "
  az deployment sub what-if \
    --name $STACK_NAME-$ACCESS_RESOURCE_IDENTIFIER \
    --location $LOCATION \
    --template-file $BICEP_FILE_PATH \
    --parameters $PARAMS_FILE_PATH
}
# -----------------------------
# Create Function for Resource Group
# -----------------------------
rg_create() {
  echo "Deploying $STACK_NAME "
  az stack sub create \
    --name $STACK_NAME-$ACCESS_RESOURCE_IDENTIFIER \
    --location $LOCATION \
    --template-file $BICEP_FILE_PATH \
    --parameters $PARAMS_FILE_PATH \
    --deny-settings-mode $DENY_SETTINGS_MODE \
    --action-on-unmanage $ACTION_ON_UNMANAGED \
    --yes
}

# -----------------------------
# Delete Function for Resource Group
# -----------------------------
rg_delete() {
  echo "Deleting Resource Group stack: $STACK_NAME"
  az stack sub delete \
    --name $STACK_NAME-$ACCESS_RESOURCE_IDENTIFIER \
    --yes
}

# -----------------------------
# What-if Function for MI, Users,Groups
# -----------------------------
what_if() {
  echo "To see planned changes in $STACK_NAME "
  az deployment group what-if \
    --name $STACK_NAME-$ACCESS_RESOURCE_IDENTIFIER \
    --resource-group $RESOURCE_GROUP \
    --template-file $BICEP_FILE_PATH \
    --parameters $PARAMS_FILE_PATH
}
# -----------------------------
# Create Function for MI, Users,Groups
# -----------------------------
create() {
  echo "Deploying $STACK_NAME "
  az stack group create \
    --name $STACK_NAME-$ACCESS_RESOURCE_IDENTIFIER \
    --resource-group $RESOURCE_GROUP \
    --template-file $BICEP_FILE_PATH \
    --parameters $PARAMS_FILE_PATH \
    --deny-settings-mode $DENY_SETTINGS_MODE \
    --action-on-unmanage $ACTION_ON_UNMANAGED \
    --yes
}

# -----------------------------
# Delete Function for MI, Users,Groups
# -----------------------------
delete() {
  echo "Deploying $STACK_NAME-$ACCESS_RESOURCE_IDENTIFIER "
  az stack group delete \
    --name $STACK_NAME \
    --resource-group $RESOURCE_GROUP \
    --action-on-unmanage deleteResources \
    --yes
}

# -----------------------------
# Parse Options (This checks whether the user provided any arguments or not when running the script.)
# -----------------------------
# Check if no arguments were provided
if [[ $# -eq 0 ]]; then
  usage
fi

# Parse each argument manually
for arg in "$@"; do
  case "$arg" in
    -rw)
      bicep_fix
      rg_what_if
      ;;
    -rc)
      bicep_fix
      rg_create
      ;;
    -rd)
      bicep_fix
      rg_delete
      ;;
    -bw)
      bicep_fix
      what_if
      ;;
    -bc)
      bicep_fix
      create
      ;;
    -bd)
      bicep_fix
      delete
      ;;
    *)
      echo "Invalid option: $arg"
      usage
      ;;
  esac
done