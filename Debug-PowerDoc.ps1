<#
.Synopsis
This is a script that I use to 
#>
Import-Module .\PowerDoc\PowerDoc.psm1 -Force

Start-PowerDoc -PathInput ".\PowerDoc\Classes" `
    -PathOutput ".\Bin\Classes" `
    -CleanOutput `
    -Classes `
    -HTML `
    -Markdown


Start-PowerDoc -PathInput ".\PowerDoc\Public" `
    -PathOutput ".\Bin\Public" `
    -CleanOutput `
    -Functions `
    -HTML `
    -Markdown


Start-PowerDoc -PathInput ".\PowerDoc\Private" `
    -PathOutput ".\Bin\Private" `
    -CleanOutput `
    -Functions `
    -HTML `
    -Markdown