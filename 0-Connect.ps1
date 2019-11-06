#---------------------------------------------------------------------------------------
# 0-Connect.ps1 - connect to Microsoft 365
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
#---------------------------------------------------------------------------------------

#------------------------------------------
# First install the modules...
# Install-Module -Name MicrosoftTeams -Force -AllowClobber -scope CurrentUser
# Install-Module -Name AzureADPreview -Force -AllowClobber -scope CurrentUser
# Update-Module -Name AzureADPreview -Force
# Uninstall-Module -Name AzureADPreview -Force
# Get a list of modules on the computer that were installed by PowerShellGet.
# Get-InstalledModule
#------------------------------------------
Import-Module MicrosoftTeams
Import-Module AzureADPreview

# Get the credebtials...
$cred = Get-Credential
$cred.password.MakeReadOnly()

# Connect to the Teams module
Connect-MicrosoftTeams -Credential $cred

# If required, connect to the AAD module
# $cred should still have a password*
Connect-AzureAD -Credential $cred

# Connect to Exchange Online
$session = New-PSSession -ConfigurationName Microsoft.Exchange `
    -ConnectionUri https://ps.outlook.com/powershell/ `
    -Credential $cred -Authentication Basic -AllowRedirection
Import-PSSession $session -AllowClobber
Write-Output "ready for Exchange Online!"

# Connect to Security & Compliance
$sessioncompliance = New-PSSession -ConfigurationName Microsoft.Exchange `
    -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ `
    -Credential $cred -Authentication Basic -AllowRedirection
Import-PSSession $sessioncompliance -DisableNameChecking -Prefix "CC"
Write-Output "ready for Security & Compliance!"

# Remove-PSSession $session 
# Remove-PSSession $sessioncompliance 







<#
Remarks for using the same credetials for multiple modules:
https://github.com/Azure/azure-docs-powershell-azuread/issues/169
RobdeJong
The password property of the credentials object is cleared after the call for security reasons - we didn't want passwords to linger around in memory for some uninvited guests to use.
If you want to re-use the password after the connect-azuread call you should make it read-only before the cmdlet call:

$cred = Get-Credential
$cred.Password.Length
$cred.password.MakeReadOnly()
Connect-AzureAD -Credential $cred
# $cred should still have a password
$cred.Password.Length
#>
