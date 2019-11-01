#---------------------------------------------------------------------------------------
# 0-Connect.ps1 - connect to Microsoft 365
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
#---------------------------------------------------------------------------------------

#------------------------------------------
# First install the modules...
# Install-Module -Name MicrosoftTeams -Force -AllowClobber -scope CurrentUser
# Install-Module -Name AzureADPreview -Force -AllowClobber -scope CurrentUser
# Get a list of modules on the computer that were installed by PowerShellGet.
# Get-InstalledModule
#------------------------------------------
Import-Module MicrosoftTeams
Import-Module AzureADPreview

# Then, connect...
$cred = Get-Credential
$cred.password.MakeReadOnly()

# Connect to the Teams module
Connect-MicrosoftTeams -Credential $cred

# If required, connect to the AAD module
# $cred should still have a password
Connect-AzureAD -Credential $cred

$session = New-PSSession -ConfigurationName Microsoft.Exchange `
    -ConnectionUri https://ps.outlook.com/powershell/ `
    -Credential $cred -Authentication Basic -AllowRedirection
Import-PSSession $Session -AllowClobber
Write-Output "ready for Exchange Online!"

# Remove-PSSession $Session 
