# metric-windows-uptime.ps1
#
# DESCRIPTION:
# This plugin collects and outputs the Uptime in seconds in a Graphite acceptable format.
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

$Counter = ((Get-Counter "\System\System Up Time").CounterSamples)

$Path = ($Counter.Path).Trim("\\") -replace " ","_" -replace "\\","." -replace "[\{\}]","" -replace "[\[\]]",""
$Value = [System.Math]::Truncate($Counter.CookedValue)
$Time = [int][double]::Parse((Get-Date -UFormat %s))

Write-Host "$Path $Value $Time"
