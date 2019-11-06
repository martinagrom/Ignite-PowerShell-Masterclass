#---------------------------------------------------------------------------------------
# 6-Owners.ps1 - list and modify owners of a group
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
#---------------------------------------------------------------------------------------

# Get Ownerless groups (< 2 owners)
$OwnerlessGroups = [array](Get-UnifiedGroup | Where-Object {([array](Get-UnifiedGroupLinks `
    -Identity $_.Id -LinkType Owners)).Count -lt 2}) | `
    Select-Object Id, DisplayName, ManagedBy, WhenCreated, SMTPAddress 
$OwnerlessGroups | ft

# Assign owner to the ownerless group
for ($i=0; $i -lt $OwnerlessGroups.Count; $i++)
{
    Add-UnifiedGroupLinks $OwnerlessGroups.Alias -LinkType member -Links NestorW@M365x251516.OnMicrosoft.com
    Add-UnifiedGroupLinks $OwnerlessGroups.Alias -LinkType Owner  -Links NestorW@M365x251516.OnMicrosoft.com
}

# Modify owner of an existing group. The new owner must already be a member!
Get-UnifiedGroup | ? {$_.DisplayName -like 'My*'}


$group = "My Monday Project"
Add-UnifiedGroupLinks $group -LinkType Member -Links MiriamG@M365x251516.OnMicrosoft.com
Add-UnifiedGroupLinks $group -LinkType Owner -Links MiriamG@M365x251516.OnMicrosoft.com

# Get all groups or a specific group
Get-AzureADGroup | ? {$_.DisplayName -eq $group}

$groupid = '629af0a9-59c3-4d3e-8b87-cf70a41b53f3'
Get-TeamUser -GroupId $groupid

# Remove user: This might take some minutes...
Remove-TeamUser -GroupId $groupid -User MiriamG@M365x251516.OnMicrosoft.com

# Check the result
Get-TeamUser -GroupId $groupid
