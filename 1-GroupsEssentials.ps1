#---------------------------------------------------------------------------------------
# 1-GroupsEssentials.ps1 - list Office 365 groups
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
#---------------------------------------------------------------------------------------

# Get all groups or a specific group
Get-UnifiedGroup | ? {$_.DisplayName -eq 'Ignite'}

# List all groups in descending order
Get-UnifiedGroup | Select Id, DisplayName, ManagedBy, Alias, AccessType, `
    WhenCreated, @{Expression={([array](Get-UnifiedGroupLinks -Identity $_.Id -LinkType `
    Members)).Count }; Label='Members'} `
    | Sort-Object whencreated `
    | Format-Table displayname, alias, managedby, Members, accesstype, whencreated

# List all private groups
Get-UnifiedGroup | Where-Object {$_.AccessType -eq 'Private'} | `
    Sort-Object whencreated | Format-Table displayname, alias, `
    managedby, accesstype, whencreated

    