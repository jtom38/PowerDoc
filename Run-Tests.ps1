# This runs the unit tests for PowerDoc

$Module = "$PsScriptRoot/PowerDoc/PowerDoc.psm1"

#Remove-Module $Module -Force
Import-Module $Module -Force
Import-Module Pester

. .\Tests\Get-BaseClasses.Test.ps1
