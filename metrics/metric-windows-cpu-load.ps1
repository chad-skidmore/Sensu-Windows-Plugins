#
# metric-windows-cpu-load
#
# DESCRIPTION:
# This plugin collects and outputs the CPU Usage in a Graphite acceptable format.
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
$All = (Get-Counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 1 -MaxSamples 1).CounterSamples

$Path = hostname
$Path = $Path.ToLower()

$Value = [Math]::Round($All.CookedValue,2)

$Time = [int][double]::Parse((Get-Date -UFormat %s))

Write-Host "$Path.system.processor_total.%_processor_time $Value $Time"
