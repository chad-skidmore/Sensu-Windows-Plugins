#
# metric-windows-uptime
#
# DESCRIPTION:
# This plugin collects and outputs the Uptime in seconds in a Graphite acceptable format.
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
$All = (Get-Counter "\System\System Up Time").CounterSamples

$Path = $All.Path
$Path = $Path.Trim("\\")
$Path = $Path -replace " ","_"
$Path = $Path -replace "\\","."
$Path = $Path -replace "[\{\}]",""
$Path = $Path -replace "[\[\]]",""

$Value = [Math]::Truncate($All.CookedValue)

$Time = [int][double]::Parse((Get-Date -UFormat %s))

Write-Host "$Path $Value $Time"
