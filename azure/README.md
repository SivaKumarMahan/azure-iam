# Azure IAM
## Overview
This repository provides a modular Bicep-based Infrastructure as Code (IaC) setup for managing Azure Identity and Access Management (IAM).
It supports provisioning of:
    - Resource Groups
    - User Assigned Managed Identities
    - Custom Role Definitions (User & Group based)
    - Predefined Role Assignments (User & Group based)

## Instructions for each stack
## 1. Resource Group
Usecase: With this stack multiple resource groups can be provisioned at a time based on user requirements.

### Steps to follow:
a. In the parameters directory, create a new folder named after the target resource group. Use an existing resource group parameter folder as a template.
b. Update the params.bicepparam file inside the new folder with the desired resource group name and location.
c. Go to the release pipeline, replace the ACCESS_RESOURCE_IDENTIFIER value and deploy the what-if and create stages in azure devops.
d. After deployment, validate the resource group creation in the Azure Portal and confirm that it appears under the specified subscription and location.

## 2. User Assigned Managed Identity
Usecase: A user needs to create Azure resources through Azure DevOps pipelines. To enable this securely, we will create a User-Assigned Managed Identity (UAMI), configure a service connection using that identity, and grant the user access to use the service connection for resource creation.

### Steps to follow:
a. Inside the parameters directory, create a new folder with the managed identity name.Use an existing managed identity parameter folder as a reference and copy it as a starting point.
b. Modify the params.bicepparam file to update the following values:
        - roleDefinitionName
        - roleName
        - roleAssignName
        - roleDescription
        - identityName
c. Adjust the Actions, NotActions, and scope sections to match the exact permissions required by the user.
d. Go to the release pipeline, replace the ACCESS_RESOURCE_IDENTIFIER value and deploy the what-if and create stages in azure devops.
e. After successful deployment, validate the managed identity in the Azure Portal to confirm correct configuration.

## 3. User Custome Role
Usecase: Sometimes a user only needs permissions to create specific resources (e.g., Storage Accounts, Key Vaults) within a resource group instead of having full Contributor access. In such scenarios, we define a custom role with the required permissions and assign it directly to the user.

### Steps to follow:
a. Get the user’s object ID from the users.json file or directly from Azure AD using az ad user show. This object ID will be used as the principal_id for role assignment.
b. In the parameters directory, create a new folder with the username. Use an existing user’s custom role parameter folder as a template.
c. Update the params.bicepparam file, including the username in roleDefinitionName, roleName, roleAssignName, and roleDescription.
d. Adjust the Actions and NotActions sections to define the exact permissions required for the role.
e. Replace the principal_id in the parameter file with the retrieved user object ID.
f. Go to the release pipeline, replace the ACCESS_RESOURCE_IDENTIFIER value and deploy the what-if and create stages in azure devops.
g. After successful deployment, validate the user’s access in the Azure portal.

## 4. Group Custom Role
Usecase: When a group of users needs specific permissions beyond built-in roles, a custom role is created and assigned to the group.

### Steps to follow:
a. Get the group’s object ID from groups.json or directly using az ad user show. This will be used as principal_id in the role assignment.
b. In the parameters directory, create a new folder with the group name. Use an existing group’s custom role folder as a template.
c. Update the params.bicepparam file by adjusting values such as roleDefinitionName, roleName, roleAssignName, and roleDescription with the group name.
d. Modify the Actions and NotActions sections to define the group’s required permissions.
e. Replace the principal_id in the parameter file with the group’s object ID.
f. Go to the release pipeline, replace the ACCESS_RESOURCE_IDENTIFIER value and deploy the what-if and create stages in azure devops.
g. After deployment, validate the group’s access in the Azure portal.

## 5. User Predefined Role
Usecase: In some cases, you don’t need to define a custom role — instead, you can assign an existing Azure built-in role (such as Reader, Contributor, or Storage Blob Data Reader) directly to a user.

### Steps to follow:
a. Get the object ID of the target user from the users.json file or by running az ad user show in Azure AD. This will be used as the principal_id for the role assignment.
b. In the parameters directory, create a new folder named after the username. You can copy an existing parameter folder (from another user’s predefined role) as a template.
c. Update the params.bicepparam file by adjusting the roleAssignName with the username.
d. Replace the principal_id with the user’s object ID.
e. Update the roleDefinitionId with the predefined role you want (e.g., Contributor, Reader, Owner).
f. Go to the release pipeline, replace the ACCESS_RESOURCE_IDENTIFIER value and deploy the what-if and create stages in azure devops.
g. After deployment, validate the user’s access in the Azure Portal.

## 6. Group Predefined Role
Usecase: Instead of assigning built-in roles to users one by one, we assign them at the group level. This approach simplifies access management and ensures consistent permissions for all members of the group.

### Steps to follow:
a. Get the object ID of the target group from the groups.json file or directly from Azure AD using az ad user show. This object ID will be used later as the principal_id for the role assignment.
b. In the parameters directory, create a new folder with the group name. Copy an existing parameter folder (from another group’s predefined role) as a template.
c. Update the params.bicepparam file by changing the group name in roleAssignName.
d. Replace the principal_id value in the parameter file with the group’s object ID.
e. Update the roleDefinitionId with the predefined IDs of roles such as Contributor, Reader, or Owner.
f. Go to the release pipeline, replace the ACCESS_RESOURCE_IDENTIFIER value and deploy the what-if and create stages in azure devops.
g. Once the deployment completes, validate the group’s access in the Azure Portal