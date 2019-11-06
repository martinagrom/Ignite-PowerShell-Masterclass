#---------------------------------------------------------------------------------------
# 3-Hide.ps1 - hide a group from the global addressbook
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
# https://docs.microsoft.com/en-us/powershell/module/exchange/users-and-groups/set-unifiedgroup?view=exchange-ps
#---------------------------------------------------------------------------------------
Get-UnifiedGroup

# Hide a specific group from Outlook with EXO PS
$groupid = '9265dc8f-2477-43b7-848b-2c13b2d91d06'

# HiddenFromAddressListsEnabled: Does the group appear in the global address list (GAL) and other address lists in your organization.
Set-UnifiedGroup -Identity $groupid -HiddenFromAddressListsEnabled $true

# HiddenFromExchangeClientsEnabled: Is the group hidden from Outlook clients connected to Office 365.
# The group isn't visible in the Outlook left-hand navigation and isn't be visible in the global address list (GAL).
# The group name won't resolve during the creation a new message in Outlook.
Set-UnifiedGroup -Identity $groupid -HiddenFromExchangeClientsEnabled:$true

# Hide multiple groups
$groups = Get-UnifiedGroup -ResultSize Unlimited | ? {$_.DisplayName -like "My*"}
$groups
Foreach ($Group in $Groups) { 
    Set-UnifiedGroup $Group.Guid -HiddenFromAddressListsEnabled $true
}
