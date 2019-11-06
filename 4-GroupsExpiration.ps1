#---------------------------------------------------------------------------------------
# 4-GroupsExpiration.ps1 - list and modify the groups expiration date
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
#---------------------------------------------------------------------------------------

# Get the current setting
Get-AzureADMSGroupLifecyclePolicy | Format-List

# Update of a policy
$LifetimeID = "f45c0130-82d0-4851-8e01-6d058ff73b7e"
Set-AzureADMSGroupLifecyclePolicy -Id $LifetimeID `
    -GroupLifetimeInDays 40 `
    -ManagedGroupTypes 'All' `
    -AlternateNotificationEmails admin@M365x251516.onmicrosoft.com

#------------------------------------------------------------
# Removes current policy
$LifetimeID = "f45c0130-82d0-4851-8e01-6d058ff73b7e"
Remove-AzureADMSGroupLifecyclePolicy -Id $LifetimeID

# Setup of new Groups Lifecycle policy (None, All, Selected)
New-AzureADMSGroupLifecyclePolicy -GroupLifetimeInDays 60 `
    -ManagedGroupTypes "All" `
    -AlternateNotificationEmails admin@M365x251516.onmicrosoft.com

# Get the current setting
Get-AzureADMSGroupLifecyclePolicy | Format-List

# Retrieves Lifecyclepolicy of a selected group
Get-UnifiedGroup | Select id, displayname

$group = "95bd1a4e-485b-4979-aff3-c3176d1b4eaa"
Get-AzureADMSLifecyclePolicyGroup  -Id $group

# Renews a group by updating the RenewedDateTime property on a group to the current DateTime.
Reset-AzureADMSLifeCycleGroup -GroupId $group 

# Adds a group to a lifecycle policy - only if ManagedGroupTypes is 'Selected'.
Add-AzureADMSLifecyclePolicyGroup -Id $LifetimeID -GroupId $group
#------------------------------------------------------------
