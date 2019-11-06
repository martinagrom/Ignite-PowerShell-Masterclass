#---------------------------------------------------------------------------------------
# 2-TeamsEssentials.ps1 - list and modify Teams
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
# See all available cmdlets at
# https://docs.microsoft.com/en-us/powershell/module/teams/connect-microsoftteams?view=teams-ps
#---------------------------------------------------------------------------------------

# Get a list of all teams
Get-Team | ? {$_.DisplayName -like 'My*'}

# Create a new-Team: might take 1-2 minutes
# New-Team -DisplayName "My Wednesday Project" -Description 'My Wednesday Project' -Visibility Private
New-Team -DisplayName "My Thursday Project" -Description 'My Thursday Project' -Visibility Private
New-Team -DisplayName "My Friday Project" -Description 'My Friday Project' -Visibility Private

# Select one group we want to work with...
$group = '583616b9-3191-439a-91fb-27add35dc0eb'

# See all channels of that group: 'Ignite'
Get-TeamChannel -GroupId $group

# Create a new team channel in that group
New-TeamChannel -GroupId $group -DisplayName 'My Ignite channel' -Description 'My Ignite'

# See some team member settings as AllowCreateUpdateChannels, AllowDeleteChannels, etc.
Get-Team -GroupId $group | fl

# Get all Team members
Get-TeamUser -GroupId $group

# Add a new user as member to that group
Add-TeamUser -GroupId $group -User nestorw@M365x251516.onmicrosoft.com
Add-TeamUser -GroupId $group -User diegoS@M365x251516.onmicrosoft.com

# Remove a user from the group
Remove-TeamUser -GroupId $group -User diegoS@M365x251516.onmicrosoft.com

# Modify that group.
# See the classifications at https://protection.office.com/sensitivitylabels
Set-Team -GroupId $group -DisplayName 'My Wednesday Ignite team' `
        -Visibility Private `
        -Classification 'Highly Confidential' `
        -Description 'My Wednesday Ignite team description' `
        -MailNickname 'myigniteteamwednesday1'

# Note: Get-TeamGuestSettings and Set-TeamFunSettings are deprecated with 1.0 PowerShell release, and are no longer supported.
# Use Get-Team and Set-Team instead.
# See two group guest settings: AllowCreateUpdateChannels, AllowDeleteChannels
Get-Team -GroupId $group | fl

# Set new Fun settings:
Set-Team -GroupId $group -AllowGiphy $true -GiphyContentRating Strict

#------------------------
# Channels
#------------------------

# Delete a channel:
Remove-TeamChannel -GroupId $group -DisplayName 'My Ignite channel'

# Note: -> The General channel cannot be removed: Message: General channel cannot be deleted.
Remove-TeamChannel -GroupId $group -DisplayName 'General'

# Check the existing channels
Get-TeamChannel -GroupId $group

#------------------------------------------
# Alternatively, use Graph API
#------------------------------------------
<#
Check the group properties with Graph Explorer
aka.ms/ge
https://graph.microsoft.com/v1.0/groups?$filter=startswith(displayname,'my')
See the channels, etc.
https://graph.microsoft.com/v1.0/teams/bdebef61-fc39-45fc-9e16-ca927ecb7601/channels/
Graph API has more actions, e.g. see the channels, e.g. see the tabs...
https://graph.microsoft.com/v1.0/teams/bdebef61-fc39-45fc-9e16-ca927ecb7601/channels/19:fac22556a2764f46b161940b3fc01600@thread.skype/tabs
#>

