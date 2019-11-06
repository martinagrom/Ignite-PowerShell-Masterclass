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

# Get a list of teams
$teams = Get-Team

# Create a new team
# $team = New-Team -DisplayName $name -Description $description -AccessType "Private" -AddCreatorAsMember $true  
# Add some channels
#New-TeamChannel -GroupId $team.GroupId -DisplayName "Project A"
#New-TeamChannel -GroupId $team.GroupId -DisplayName "Project B"

Write-Output $teams

Write-Output "Done."
