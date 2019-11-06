#---------------------------------------------------------------------------------------
# a2-Variables.ps1 - work with Variables
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
# https://docs.microsoft.com/en-us/azure/automation/shared-resources/variables
#---------------------------------------------------------------------------------------
Write-Output "Hello, $name at $(Get-Date)"

# not encrypted
$SomeText1 = Get-AutomationVariable -Name "SomeText1"
Write-Output "The value of 'SomeText1' is '$($SomeText1)'."

# encrypted
$SomeText2 = Get-AutomationVariable -Name "SomeText2"
Write-Output "The value of 'SomeText2' is '$($SomeText2)'."

