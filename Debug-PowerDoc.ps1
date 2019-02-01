<#
.Synopsis
This is a script that I use to 
#>
Import-Module .\PowerDoc\PowerDoc.psm1 -Force

#. .\PowerDoc\Private\Get-ClassHelp.ps1
#$hash = Get-ClassHelp -PathClassFile ".\PowerDoc\Classes\ExampleClass.ps1"

# MarkDown
## Classes
# Tests a class file with Help Comments
Start-PowerDoc -PathInput ".\PowerDoc\Classes\ExampleClass.ps1" `
    -PathOutput ".\Bin\Classes" `
    -CleanOutput `
    -Classes `
    -Markdown

# Tests a class file without help comments
Start-PowerDoc -PathInput ".\PowerDoc\Classes\ExampleBaseClass.ps1" `
    -PathOutput ".\Bin\Classes" `
    -Classes `
    -Markdown

## Functions
# Start-PowerDoc is full of comments that will be extracted
Start-PowerDoc -PathInput ".\PowerDoc\Public" `
    -PathOutput ".\Bin\Public" `
    -CleanOutput `
    -Functions `
    -Markdown

Start-PowerDoc -PathInput ".\PowerDoc\Private" `
    -PathOutput ".\Bin\Private" `
    -CleanOutput `
    -Functions `
    -Markdown

# HTML
## Classes

Start-PowerDoc -PathInput ".\PowerDoc\Classes\ExampleClass.ps1" `
    -PathOutput ".\Bin\Classes" `
    -Classes `
    -HTML

# Tests a class file without help comments
Start-PowerDoc -PathInput ".\PowerDoc\Classes\ExampleBaseClass.ps1" `
    -PathOutput ".\Bin\Classes" `
    -Classes `
    -HTML

## Functions
# Start-PowerDoc is full of comments that will be extracted
Start-PowerDoc -PathInput ".\PowerDoc\Public" `
    -PathOutput ".\Bin\Public" `
    -Functions `
    -HTML

Start-PowerDoc -PathInput ".\PowerDoc\Private" `
    -PathOutput ".\Bin\Private" `
    -Functions `
    -HTML