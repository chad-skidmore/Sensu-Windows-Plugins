# metric-windows-network.ps1
#
# DESCRIPTION:
# This plugin collects and outputs all Network Adapater Statistic in a Graphite acceptable format.
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

foreach ($ObjNet in (Get-Counter -Counter "\Network Interface(*)\*").CounterSamples) 
{ 
  $Path = ($ObjNet.Path).Trim("\\") -replace "\\","." -replace " ","_" -replace "[(]","." -replace "[)]","" -replace "[\{\}]","" -replace "[\[\]]",""
  $Value = [System.Math]::Round(($ObjNet.CookedValue),0)
  $Time = [int][double]::Parse((Get-Date -UFormat %s))

  Write-Host "$Path $Value $Time"
}
