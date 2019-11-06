#---------------------------------------------------------------------------------------
# 5-SoftDelete.ps1 - delete groups
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
#---------------------------------------------------------------------------------------

# Get all groups or a specific group
Get-AzureADGroup | ? {$_.DisplayName -eq 'My Ignite team'}

# Soft Delete a specific group
$ToDelete = "629af0a9-59c3-4d3e-8b87-cf70a41b53f3"
Remove-AzureADGroup -ObjectId $ToDelete 

# Show all Soft Deleted Groups in descending order
Get-AzureADMSDeletedGroup | Sort-Object DeletedDateTime -Descending | `
    Format-Table Id, DisplayName, Description, Visibility, DeletedDateTime

# Restore a specific soft deleted group
Restore-AzureADMSDeletedDirectoryObject -Id $ToDelete

# Get all groups or a specific group
Get-AzureADGroup | ? {$_.DisplayName -eq 'My Ignite team'}

# Hard Delete a Group
Remove-AzureADMSDeletedDirectoryObject -Id $ToDelete
