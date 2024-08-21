# SIMPLE Azure AD Configuration for an enterprise environment.

# Installing the Azure AD module
Install-Module -Name AzureAD

# Connecting into the Azure AD
Connect-AzureAD

# Create a new user
New-AzureADUser -DisplayName "Moun moun" -PasswordProfile (New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile -Property @{Password="wEAkPassw@rd123"; ForceChangePasswordNextLogin=$true}) -UserPrincipalName "johndoe@yourdomain.com" -AccountEnabled $true

# User --» security group
Add-AzureADGroupMember -ObjectId <GroupObjectId> -RefObjectId <UserObjectId>

# mfa 
Set-MsolUser -UserPrincipalName "mounmoun@domain.com" -StrongAuthenticationRequirements @()

#Conditional Access Policy
New-AzureADMSConditionalAccessPolicy -DisplayName "Require MFA for Admins" -State "Enabled" -Conditions @{Users=@{IncludeUsers=@("All"); ExcludeUsers=@()}; Platforms=@{IncludePlatforms=@("All"); ExcludePlatforms=@()}} -GrantControls @{BuiltInControls=@("MFA")}
