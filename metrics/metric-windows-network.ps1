#
# metric-windows-network.ps1
#
# DESCRIPTION:
# This plugin collects and outputs all Network Adapater Statistic in a Graphite acceptable format.
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
$AllAdapters = Get-Counter -Counter "\Network Interface(*)\*"

foreach ($ObjNet in $AllAdapters.CounterSamples) 
{ 
  $Path = $ObjNet.Path
  $Path = $Path.Trim("\\")
  $Path = $Path -replace "\\","."
  $Path = $Path -replace " ","_"
  $Path = $Path -replace "[(]","."
  $Path = $Path -replace "[)]",""
  $Path = $Path -replace "[\{\}]",""
  $Path = $Path -replace "[\[\]]",""

  $Value = $ObjNet.CookedValue
  $Value = [Math]::Round($Value,0)

  $Time = [int][double]::Parse((Get-Date -UFormat %s))

  Write-Host "$Path $Value $Time"
}
