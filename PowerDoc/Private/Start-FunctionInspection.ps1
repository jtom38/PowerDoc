
<#
.Synopsis
This function looks at the file in question and extracts information from it for processing.

.Description
This is a private function that will not be exposed.

.Parameter File
[string] Defines the function source file that will be inspected.

.Example
Start-FunctionInspection -File ".\PowerDoc\Start-PowerDoc.ps1"

.Outputs
[void]
#>

function Start-FunctionInspection {
    param (
        [Parameter(Mandatory=$true)]
        [string] $File,

        [switch] $Markdown,
        [switch] $HTML
    )

    Process {
        
        $info = [System.IO.FileInfo]::new($File)
            
        # Get the raw text of the file
        $raw = Get-Content -Path $File

        $FunctionName = ''
        $SearchForHelpDocs = $false
        $HelpDocs = ''

        #$HelpDocs = Get-Help $FunctionName
        $HelpDocs = Find-HelpDocs -PathFile $info.FullName

        $stop = $false
        foreach ( $l in $raw ) {

            if ($stop -eq $true){
                # Bail out of the foreach loop.  We found what we needed.
                Continue
            }

            if ($l.Contains('function') -and $l.Contains('{') -eq $true) {
                $words = $l.Split(' ')
                $FunctionName = $words[1]

                if ( $Markdown -eq $true ) {
                    Export-FunctionToMarkdown -FunctionName $FunctionName -HelpDocs $HelpDocs
                }

                if ( $HTML -eq $true ) {
                    Export-FunctionToHtml -FunctionName $FunctionName -HelpDocs $HelpDocs
                }
                
                $stop = $true
                Continue
            }

        }

    }
    
}