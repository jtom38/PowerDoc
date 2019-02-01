<#
.Synopsis
Starts the process off to build documentation

.Description
This is a function that you can use in a build process to document your commands.

.Parameter PathOutput
Type: String
This defines where the files will be exported to once they are built.

.Parameter PathInput
Type: String
This defines the source of the files that you want to convert into documentation.
This is only a string currently.  You can direct it to a single file or a folder.

.Parameter CleanOutput
Type: Switch
Use this switch if you want to have PowerDoc remove the output folder and rebuild.

.Parameter Recurse
Type: Switch
This is a flag that goes in tandum with PathInput.  If you toggle this switch the code will look though all folders under that layer.

.Parameter Classes
Type: Switch
Switch to define that we are looking at class files.

.Parameter Functions
Type: Switch
Switch to define that we are looking at function files.

.Parameter Markdown
Type: Switch
Defines that export of the files will be in .md format.

.Parameter HTML
Type: Switch
Defines that the export of the files will be in .html format.

.Example
Start-PowerDoc -PathOutput ".\docs" -PathInput ".\src" -Classes
Start-PowerDoc -PathOutput ".\docs" -PathInput ".\src" -Functions

.Outputs
[void]

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
        [switch] $Functions,

        # Define Output Types
        [switch] $Markdown,
        [switch] $HTML
    )
    
    Process {

        if ( $Recurse -eq $true ){
            $Files  = Get-ChildItem -Path $PathInput -Filter *.ps1 -Recurse
        }else{
            $Files  = Get-ChildItem -Path $PathInput -Filter *.ps1
        }   
        $FilesCount = $Files | Measure-Object 

        if ( $FilesCount.Count -eq 0 ) {
            throw "PathInput: No .ps1 files found with provided path."
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

        foreach ($f in $Files) {

            try {
                $Global:PowerDoc.Remove("File")
                $Global:PowerDoc.Add("File", $f)
            }
            catch {
                $Global:PowerDoc.Add("File", $f)
            }

            if ( $Classes -eq $true ){

                if ( $Markdown -eq $true -and $HTML -eq $true ){
                    Start-ClassInspection -File $f.FullName -Markdown -HTML
                    Continue
                }

                if ( $Markdown -eq $true ) {
                    Start-ClassInspection -File $f.FullName -Markdown
                }
                
                if ( $HTML -eq $true ) {
                    Start-ClassInspection -File $f.FullName -HTML
                }
                
            }
            else {
                if ( $Markdown -eq $true -and $HTML -eq $true ){
                    Start-FunctionInspection -File $f.FullName -Markdown -HTML
                    Continue
                }

                if ($Markdown -eq $true){
                    Start-FunctionInspection -File $f.FullName -Markdown
                }

                if ( $HTML -eq $true ){
                    Start-FunctionInspection -File $f.FullName -HTML    
                }                
            }
        }
    }
}