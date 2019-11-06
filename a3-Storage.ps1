#---------------------------------------------------------------------------------------
# a3-Storage.ps1 - write content to an Azure Storage Blob
# Microsoft Teams and Office 365 Groups PowerShell Masterclass - by @magrom and @atwork
#---------------------------------------------------------------------------------------

# Create a new local logfile with some content
$todaydate = Get-Date -Format yyyy-MM-dd-HH-mm-ss 
$logfile = "MyLogfile-$todaydate.log" 
$content = "$logfile`nThis is some content of the logfile." 
$content | Out-File -FilePath .\$logfile -NoClobber

# Get a storage context
$storage = Get-AutomationVariable -Name "Storage"
$storagekey = Get-AutomationVariable -Name "StorageKey"

$storageContext = New-AzureStorageContext -StorageAccountName $storage -StorageAccountKey $storagekey

# Copy the file to the storage account with no output
Set-AzureStorageBlobContent -File $logfile -Container "myfiles" -BlobType "Block" -Context $storageContext -Verbose

Write-Output "Created $($logfile)."

