
Import-Module .\PowerDoc\PowerDoc.psm1 -Force

Start-PowerDoc -PathInput ".\PowerDoc\Classes\ExampleClass.ps1" `
-PathOutput ".\Docs\Classes" `
-CleanOutput `
-Classes `
-Markdown

# Tests a class file without help comments
Start-PowerDoc -PathInput ".\PowerDoc\Classes\ExampleBaseClass.ps1" `
-PathOutput ".\Docs\Classes" `
-Classes `
-Markdown

## Functions
# Start-PowerDoc is full of comments that will be extracted
Start-PowerDoc -PathInput ".\PowerDoc\Public" `
-PathOutput ".\Docs\Public" `
-CleanOutput `
-Functions `
-Markdown

Start-PowerDoc -PathInput ".\PowerDoc\Private" `
-PathOutput ".\Docs\Private" `
-CleanOutput `
-Functions `
-Markdown

# HTML
## Classes

Start-PowerDoc -PathInput ".\PowerDoc\Classes\ExampleClass.ps1" `
-PathOutput ".\Docs\Classes" `
-Classes `
-HTML

# Tests a class file without help comments
Start-PowerDoc -PathInput ".\PowerDoc\Classes\ExampleBaseClass.ps1" `
-PathOutput ".\Docs\Classes" `
-Classes `
-HTML

## Functions
# Start-PowerDoc is full of comments that will be extracted
Start-PowerDoc -PathInput ".\PowerDoc\Public" `
-PathOutput ".\Docs\Public" `
-Functions `
-HTML

Start-PowerDoc -PathInput ".\PowerDoc\Private" `
-PathOutput ".\Docs\Private" `
-Functions `
-HTML