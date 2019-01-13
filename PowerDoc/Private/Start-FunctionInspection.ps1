
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
        foreach ( $l in $raw ) {

            if ($l.Contains('function') -and $l.Contains('{') -eq $true) {
                $words = $l.Split(' ')
                $FunctionName = $words[1]

                $HelpDocs = Get-Help $FunctionName
                ConvertTo-Markdown -Function -FunctionName $FunctionName -HelpDocs $HelpDocs
            }

        }

    }
    
}