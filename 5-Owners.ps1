#---------------------------------------------------------------------------------------
# 5-Owners.ps1 - list and modify owners of a group
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
    Add-UnifiedGroupLinks $OwnerlessGroups.Alias -LinkType member -Links <username>@<tenant-name>.OnMicrosoft.com
    Add-UnifiedGroupLinks $OwnerlessGroups.Alias -LinkType Owner  -Links <username>@<tenant-name>.OnMicrosoft.com
}

# Modify owner of an existing group. The new owner must already be a member!
$group = "<group-name>"
Add-UnifiedGroupLinks $group -LinkType Member -Links <username>@<tenant-name>.OnMicrosoft.com
Add-UnifiedGroupLinks $group -LinkType Owner -Links <username>@<tenant-name>.OnMicrosoft.com

# Get all groups or a specific group
Get-AzureADGroup | ? {$_.DisplayName -eq $group}

$groupid = '<group-id>'
Get-TeamUser -GroupId $groupid

# Remove user: This might take some minutes...
Remove-TeamUser -GroupId $groupid -User <username>@<tenant-name>.OnMicrosoft.com
Get-TeamUser -GroupId $groupid
