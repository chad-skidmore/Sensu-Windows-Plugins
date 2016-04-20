#
# check-windows-cpu-load.rb
#
# DESCRIPTION:
# This plugin collects the CPU Usage and compares WARNING and CRITICAL thresholds.
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

$All = (Get-Counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 1 -MaxSamples 1).CounterSamples

$Value = [Math]::Round($All.CookedValue,2)

If ($Value -gt $CRITICAL) {
  Write-Host CheckWindowsCpuLoad CRITICAL: CPU at $Value%.
  break }

If ($Value -gt $WARNING) {
  Write-Host CheckWindowsCpuLoad WARNING: CPU at $Value%.
  break }

Else { Write-Host CheckWindowsCpuLoad OK: CPU at $Value%. }
