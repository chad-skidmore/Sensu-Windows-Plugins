#
# metric-windows-ram-usage.ps1
#
# DESCRIPTION:
# This plugin collects and outputs the Ram Usage in a Graphite acceptable format.
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
$FreeMemory = (Get-WmiObject -Query "SELECT TotalVisibleMemorySize, FreePhysicalMemory FROM Win32_OperatingSystem").FreePhysicalMemory
$TotalMemory = (Get-WmiObject -Query "SELECT TotalVisibleMemorySize, FreePhysicalMemory FROM Win32_OperatingSystem").TotalVisibleMemorySize

$Path = hostname
$Path = $Path.ToLower()

$Value = ($TotalMemory - $FreeMemory) / $TotalMemory
$Value = $Value * 100
$Value = [Math]::Round($Value,2)

$Time = [int][double]::Parse((Get-Date -UFormat %s))

Write-host "$Path.system.ram.RamUsagePercent $Value $Time"
