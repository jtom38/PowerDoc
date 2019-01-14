<#
.Synopsis
This is a script that I use to 
#>

Remove-Module .\PowerDoc\PowerDoc.psm1 -Force
Import-Module .\PowerDoc\PowerDoc.psm1 -Force


Start-PowerDoc -PathInput ".\PowerDoc\Classes" `
    -PathOutput ".\Docs\Classes" `
    -CleanOutput `
    -Classes `
    -HTML `
    -Markdown


Start-PowerDoc -PathInput ".\PowerDoc\Public" `
    -PathOutput ".\Docs\Public" `
    -CleanOutput `
    -Functions `
    -HTML `
    -Markdown


Start-PowerDoc -PathInput ".\PowerDoc\Private" `
    -PathOutput ".\Docs\Private" `
    -CleanOutput `
    -Functions `
    -HTML `
    -Markdown