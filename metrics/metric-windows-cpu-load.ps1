# metric-windows-cpu-load.ps1
#
# DESCRIPTION:
# This plugin collects and outputs the CPU Usage in a Graphite acceptable format.
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

$Path = hostname
$Path = $Path.ToLower()

$Value = (Get-WmiObject CIM_Processor).LoadPercentage

$Time = [int][double]::Parse((Get-Date -UFormat %s))

Write-Host "$Path.system.processor_total.%_processor_time $Value $Time"
