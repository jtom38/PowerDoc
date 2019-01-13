
function Start-FunctionInspection {
    param (
        [Parameter(Mandatory=$true)]
        [string] $File
    )

    Process {
        
        $info = [System.IO.FileInfo]::new($File)
            
        # Get the raw text of the file
        $raw = Get-Content -Path $File

        $FunctionName = ''
        $SearchForHelpDocs = $false
        $HelpDocs = ''

        $stop = $false
        foreach ( $l in $raw ) {

            if ($stop -eq $true){
                # Bail out of the foreach loop.  We found what we needed.
                Continue
            }

            if ($l.Contains('function') -and $l.Contains('{') -eq $true) {
                $words = $l.Split(' ')
                $FunctionName = $words[1]

                $HelpDocs = Get-Help $FunctionName
                ConvertTo-Markdown -Function -FunctionName $FunctionName -HelpDocs $HelpDocs
                $stop = $true
                Continue
            }

        }

    }
    
}