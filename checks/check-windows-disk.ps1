#
# check-windows-disk.rb
#
# DESCRIPTION:
# This plugin collects the Disk Usage and and compares WARNING and CRITICAL thresholds.
#
# OUTPUT:
# Plain Text
#
# PLATFORMS:
# Windows
#
# DEPENDENCIES:
# Powershell
#
[CmdletBinding()]
Param(
   [Parameter(Mandatory=$True,Position=1)] 
   [string]$WARNING,

   [Parameter(Mandatory=$True,Position=2)]
   [string]$CRITICAL,

# Example "abz"
   [Parameter(Mandatory=$False,Position=3)]
   [string]$IGNORE
)

If ($IGNORE -eq "") { $IGNORE = "ab" }

$BrownChickenBrownCow = 0

$AllDisks = Get-WMIObject Win32_LogicalDisk -Filter "DriveType = 3"
$AllDisks = $AllDisks | ? { $_.DeviceID -notmatch "[$IGNORE]:"}

foreach ($ObjDisk in $AllDisks) 
{ 
  $UsedSpace = $ObjDisk.Size - $ObjDisk.Freespace
  $UsedPercentage = ($UsedSpace/$ObjDisk.Size)*100
  $UsedPercentage = [Math]::Round($UsedPercentage,2)

  If ($UsedPercentage -gt $CRITICAL) {
    Write-Host CheckDisk CRITICAL: $ObjDisk.DeviceID $UsedPercentage%.
    $BrownChickenBrownCow =+ 1
  break }

  If ($UsedPercentage -gt $WARNING) {
    Write-Host CheckDisk WARNING: $ObjDisk.DeviceID $UsedPercentage%.
    $BrownChickenBrownCow =+ 1
  break }
}

If ($BrownChickenBrownCow -eq 0) { Write-Host CheckDisk OK: All disk usage under $WARNING%. }
