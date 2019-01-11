
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
        [switch] $Classes
        #[switch] $Functions,

        # Define Output Types
        #[switch] $Markdown
        #[switch] $HTML
    )
    
    Process {

        if ( [System.IO.Directory]::Exists($PathInput) -eq $false ) {
            throw "PathInput: $PathInput was not found."
        }

        if ( [System.IO.Directory]::Exists($PathOutput) -eq $false) {
            [System.IO.Directory]::CreateDirectory($PathOutput) | Out-Null
        }

        if ( $CleanOutput -eq $true ) {
            [System.IO.Directory]::Delete($PathOutput)
            [System.IO.Directory]::CreateDirectory($PathOutput) | Out-Null
        }

        if ( $Recurse -eq $true ){
            $Files  = Get-ChildItem -Path $PathInput -Filter *.ps1 -Recurse
        }else{
            $Files  = Get-ChildItem -Path $PathInput -Filter *.ps1
        }        

        foreach ($f in $Files) {

            if ( $Classes -eq $true ){
                Start-ClassInspection -File $f.FullName -Markdown
            }
        }
    }

}