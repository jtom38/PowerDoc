<#
.SYNOPSIS
Starts the process off to build documentation

.DESCRIPTION
This is a function that you can use in a build process to document your commands.

.Example
Start-PowerDoc -PathOutput ".\docs" -PathInput ".\src" -Classes

.Example
Start-PowerDoc -PathOutput ".\docs" -PathInput ".\src" -Functions

.Outputs
Returns nothing.

#>
function Start-PowerDoc {
    param (
        [Parameter(Mandatory=$true)]
        [string] $PathOutput,
        [switch] $CleanOutput,

        [Parameter(Mandatory=$true)]
        [string] $PathInput,

        # Do we look deeper? EX: Classes, Public, Private folders
        [switch] $Recurse,

        # Define the Code Type
        [switch] $Classes,
        [switch] $Functions

        # Define Output Types
        #[switch] $Markdown
        #[switch] $HTML
    )
    
    Process {

        if ( [System.IO.Directory]::Exists($PathInput) -eq $false ) {
            throw "PathInput: $PathInput was not found."
        }

        $Global:PowerDoc = @{
            "PathOutput" = $PathOutput
            "PathInput" = $PathInput
        }

        if ( [System.IO.Directory]::Exists($PathOutput) -eq $false) {
            [System.IO.Directory]::CreateDirectory($PathOutput) | Out-Null
        }

        if ( $CleanOutput -eq $true ) {
            [System.IO.Directory]::Delete($PathOutput, $true)
            [System.IO.Directory]::CreateDirectory($PathOutput) | Out-Null
        }


        if ( $Recurse -eq $true ){
            $Files  = Get-ChildItem -Path $PathInput -Filter *.ps1 -Recurse
        }else{
            $Files  = Get-ChildItem -Path $PathInput -Filter *.ps1
        }        

        foreach ($f in $Files) {

            if ( $Classes -eq $true ){
                try {
                    $Global:PowerDoc.Remove("File")
                    $Global:PowerDoc.Add("File", $f)
                }
                catch {
                    $Global:PowerDoc.Add("File", $f)
                }
                
                Start-ClassInspection -File $f.FullName -Markdown
            }
            else {

                try {
                    $Global:PowerDoc.Remove("File", $f)
                    $Global:PowerDoc.Add("File", $f)
                }
                catch {
                    $Global:PowerDoc.Add("File", $f)
                }

                Start-FunctionInspection -File $f.FullName
            }
        }

        Write-Host "All files have been processed." 
    }

}