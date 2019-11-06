#---------------------------------------------------------------------------------------
# 3-Hide.ps1 - hide a group from the global addressbook
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
# https://docs.microsoft.com/en-us/powershell/module/exchange/users-and-groups/set-unifiedgroup?view=exchange-ps
#---------------------------------------------------------------------------------------
Get-UnifiedGroup

# Hide a specific group from Outlook with EXO PS
$groupid = '583616b9-3191-439a-91fb-27add35dc0eb'

# HiddenFromAddressListsEnabled: Does the group appear in the global address list (GAL) and other address lists in your organization.
Set-UnifiedGroup -Identity $groupid -HiddenFromAddressListsEnabled $false

# HiddenFromExchangeClientsEnabled: Is the group hidden from Outlook clients connected to Office 365.
# The group isn't visible in the Outlook left-hand navigation and isn't be visible in the global address list (GAL).
# The group name won't resolve during the creation a new message in Outlook.
Set-UnifiedGroup -Identity $groupid -HiddenFromExchangeClientsEnabled:$false

# Hide multiple groups
$groups = Get-UnifiedGroup -ResultSize Unlimited | ? {$_.DisplayName -like "My*"}
$groups
Foreach ($Group in $Groups) { 
    Set-UnifiedGroup -Identity $Group.Guid -HiddenFromAddressListsEnabled $false
    Set-UnifiedGroup -Identity $Group.Guid -HiddenFromExchangeClientsEnabled:$false
}
