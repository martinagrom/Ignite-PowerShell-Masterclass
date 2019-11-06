# https://practical365.com/microsoft-365/how-to-run-powershell-scripts-to-automate-manual-processes-in-office-365/


# https://docs.microsoft.com/en-us/azure/automation/automation-first-runbook-textual#step-5---add-authentication-to-manage-azure-resources
Import-Module MicrosoftTeams

# Then, connect...

$cred = Get-AutomationPSCredential -Name 'admin@M365x251516.onmicrosoft.com'
Connect-AzAccount -Credential $cred

Write-Output "Credential : $($cred.UserName)"
Write-Output "Pwd : $($cred.Password)"

# Connect to the Teams module
Connect-MicrosoftTeams -Credential $cred

$teams = Get-Team

#$team = New-Team -DisplayName $name -Description $description -AccessType "Private" -AddCreatorAsMember $true  
#add some channels
#New-TeamChannel -GroupId $team.GroupId -DisplayName "Projektmanagement"
#New-TeamChannel -GroupId $team.GroupId -DisplayName "Teilprojekt 1"
#New-TeamChannel -GroupId $team.GroupId -DisplayName "Teilprojekt 2"

Write-Output $teams

Write-Output "Done."
