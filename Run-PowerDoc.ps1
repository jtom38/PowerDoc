Import-Module .\PowerDoc\PowerDoc.psm1 -Force


Start-PowerDoc -PathInput ".\PowerDoc\Public" `
    -PathOutput ".\Docs\Public" `
    -CleanOutput `
    -Functions

Start-PowerDoc -PathInput ".\PowerDoc\Private" `
    -PathOutput ".\Docs\Private" `
    -CleanOutput `
    -Functions


Start-PowerDoc -PathInput ".\PowerDoc\Classes" `
    -PathOutput ".\Docs\Classes" `
    -CleanOutput `
    -Classes
    