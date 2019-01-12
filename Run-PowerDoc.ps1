Import-Module .\PowerDoc\PowerDoc.psm1 -Force

Start-PowerDoc -PathInput ".\PowerDoc\Classes" `
    -PathOutput ".\bin\Classes" `
    -CleanOutput `
    -Classes

