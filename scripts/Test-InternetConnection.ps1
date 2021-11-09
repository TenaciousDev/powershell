Function Test-InternetConnection {
  <#
  .SYNOPSIS
      Use this function to test your internet connection and monitor while it is down.
  .DESCRIPTION
      Use this function to test your internet connection and monitor while it is down. When the connection is back up, a text notification will show up.
  .PARAMETER Site
      Name of the site to use for connection test.
  .PARAMETER Wait
      Time to wait before retrying Test-Connection (seconds)
  .NOTES
      Author     : Boe Prox (modified by Adam Metcalf)
      Created    : 05Feb2011 (modified 09Nov2021)
  .LINK
      https://boeprox.wordpress.com
  #>
  [cmdletbinding(
      DefaultParameterSetName = 'Site'
  )]
  param(
      [Parameter(
          Mandatory = $True,
          ParameterSetName = '',
          ValueFromPipeline = $True)]
          [string]$Site,
      [Parameter(
          Mandatory = $True,
          ParameterSetName = '',
          ValueFromPipeline = $False)]
          [Int]$Wait
      )
      #Clear the screen
      Clear-Host
      #Start testing the connection and continue until the connection is good.
      While (!(Test-Connection -computer $site -count 1 -quiet)) {
          Write-Host -ForegroundColor Red -NoNewline "Connection down..."
          Start-Sleep -Seconds $wait
          }
      #Connection is good
      Write-Host -ForegroundColor Green "$(Get-Date): Connection up!"
      $Shell = New-Object -ComObject "WScript.Shell"
      $Shell.Popup("Connection established to ${site}!", 0, "Internet Status", 0)
  }