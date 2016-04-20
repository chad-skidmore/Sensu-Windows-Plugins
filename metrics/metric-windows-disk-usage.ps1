#
# metric-windows-disk-usage
#
# DESCRIPTION:
# This plugin collects and outputs Disk Usage metrics in a Graphite acceptable format.
#
# OUTPUT:
# metric data
#
# PLATFORMS:
# Windows
#
# DEPENDENCIES:
# Powershell
#
$AllDisks = Get-WMIObject Win32_LogicalDisk -Filter "DriveType = 3"
$AllDisks = $AllDisks | ? { $_.DeviceID -notmatch "[ab]:"}

foreach ($ObjDisk in $AllDisks) 
{ 
  $DeviceId = $ObjDisk.DeviceID
  $DeviceId = $DeviceID -replace ":",""

  $UsedSpace = $ObjDisk.Size - $ObjDisk.Freespace
  $UsedPercentage = ($UsedSpace/$ObjDisk.Size)*100

  $UsedSpace = $UsedSpace/1MB
  $Freespace = $ObjDisk.Freespace/1MB

  $UsedSpace = [Math]::Round($UsedSpace,2)
  $Freespace = [Math]::Round($Freespace,2)
  $UsedPercentage = [Math]::Round($UsedPercentage,2)

  $Path = hostname
  $Path = $Path.ToLower()

  $Time = [int][double]::Parse((Get-Date -UFormat %s))

  Write-Host "$Path.system.Disk.$DeviceId.UsedMB $UsedSpace $Time"
  Write-Host "$Path.system.Disk.$DeviceId.FreeMB $Freespace $Time"
  Write-Host "$Path.system.Disk.$DeviceId.UsedPercentage $UsedPercentage $Time"
}
