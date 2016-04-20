#
# check-windows-ram.rb
#
# DESCRIPTION:
# This plugin collects the RAM Usage and compares WARNING and CRITICAL thresholds.
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
   [string]$CRITICAL
)

$FreeMemory = (Get-WmiObject -Query "SELECT TotalVisibleMemorySize, FreePhysicalMemory FROM Win32_OperatingSystem").FreePhysicalMemory
$TotalMemory = (Get-WmiObject -Query "SELECT TotalVisibleMemorySize, FreePhysicalMemory FROM Win32_OperatingSystem").TotalVisibleMemorySize

$Value = ($TotalMemory - $FreeMemory) / $TotalMemory
$Value = $Value * 100
$Value = [Math]::Round($Value,2)

If ($Value -gt $CRITICAL) {
  Write-Host CheckWindowsRAMLoad CRITICAL: CPU at $Value%.
  break }

If ($Value -gt $WARNING) {
  Write-Host CheckWindowsRAMLoad WARNING: CPU at $Value%.
  break }

Else { Write-Host CheckWindowsRAMLoad OK: RAM at $Value%. }
