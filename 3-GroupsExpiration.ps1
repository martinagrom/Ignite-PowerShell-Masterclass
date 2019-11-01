#---------------------------------------------------------------------------------------
# 3-GroupsExpiration.ps1 - list and modify the groups expiration date
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
#---------------------------------------------------------------------------------------

# Get the current setting
Get-AzureADMSGroupLifecyclePolicy | Format-List

# Removes current policy
$LifetimeID = "<guid>"
Remove-AzureADMSGroupLifecyclePolicy -Id $LifetimeID

# Setup of new Groups Lifecycle policy (None, All, Selected)
New-AzureADMSGroupLifecyclePolicy -GroupLifetimeInDays 60 `
    -ManagedGroupTypes "All" `
    -AlternateNotificationEmails admin@<tenant-name>.onmicrosoft.com

# Get the current setting
Get-AzureADMSGroupLifecyclePolicy | Format-List

# Update of a policy
$LifetimeID = "<new-guid>"
Set-AzureADMSGroupLifecyclePolicy -Id $LifetimeID `
    -GroupLifetimeInDays 40 `
    -ManagedGroupTypes 'All' `
    -AlternateNotificationEmails admin@<tenant-name>.onmicrosoft.com

# Retrieves Lifecyclepolicy of a selected group
Get-UnifiedGroup | Select id, displayname

$group = "<group-id>"
Get-AzureADMSLifecyclePolicyGroup -Id $group

# Renews a group by updating the RenewedDateTime property on a group to the current DateTime.
Reset-AzureADMSLifeCycleGroup -GroupId $group 

# Adds a group to a lifecycle policy - only if ManagedGroupTypes is 'Selected'.
Add-AzureADMSLifecyclePolicyGroup -Id $LifetimeID -GroupId $group
