# metric-windows-disk-usage.ps1
#
# DESCRIPTION:
# This plugin collects and outputs Disk Usage metrics in a Graphite acceptable format.
#
# OUTPUT:
# Metric Data in Plain Text
#
# PLATFORMS:
# Windows
#
# DEPENDENCIES:
# Powershell
#
$ThisProcess = Get-Process -Id $pid
$ThisProcess.PriorityClass = "BelowNormal"

$AllDisks = Get-WMIObject Win32_LogicalDisk -Filter "DriveType = 3" | ? { $_.DeviceID -notmatch "[ab]:"}

foreach ($ObjDisk in $AllDisks) 
{
  $DeviceId = $ObjDisk.DeviceID -replace ":",""

  $UsedSpace = [System.Math]::Round((($ObjDisk.Size-$ObjDisk.Freespace)/1MB),2)
  $AvailableSpace = [System.Math]::Round(($ObjDisk.Freespace/1MB),2)
  $UsedPercentage = [System.Math]::Round(((($ObjDisk.Size-$ObjDisk.Freespace)/$ObjDisk.Size)*100),2)

  $Path = (hostname).ToLower()

  $Time = [int][double]::Parse((Get-Date -UFormat %s))

  Write-Host "$Path.system.Disk.$DeviceId.UsedMB $UsedSpace $Time"
  Write-Host "$Path.system.Disk.$DeviceId.FreeMB $AvailableSpace $Time"
  Write-Host "$Path.system.Disk.$DeviceId.UsedPercentage $UsedPercentage $Time"
}
