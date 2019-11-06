#---------------------------------------------------------------------------------------
# 7-SensitivityLabels.ps1 - Office 365 Security & Compliance Center PowerShell
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
# https://docs.microsoft.com/en-us/powershell/exchange/office-365-scc/connect-to-scc-powershell/connect-to-scc-powershell?view=exchange-ps
#---------------------------------------------------------------------------------------

# Show the labels
Get-Label | ft

Get-Label | fl

# Set a new label policy
# Set-LabelPolicy -Identity <PolicyName> -AdvancedSettings @{Key=ConvertTo-Json("value1", "value2")}

# Set new labels
# $guid = New-Guid
# Set-Label -Identity $guid -AdvancedSettings @{Key=ConvertTo-Json("General", "Internal","Highly Confidential")}

# Remove-PSSession $sessioncompliance
