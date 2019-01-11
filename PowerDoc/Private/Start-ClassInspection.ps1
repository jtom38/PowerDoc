
function Start-ClassInspection {
    param (
        [string] $File,
        [switch] $Markdown
    )
    
    Process {
        
    #[string] $Class = ".\PsLog\Classes\PsLog.ps1"
    
    if ([System.String]::IsNullOrEmpty($File) -eq $false) {
    
        $Constructors = @()
        $Properties = @()
        $Methods = @()
    
        $ClassName = ''
    
        $info = [System.IO.FileInfo]::new($File)
        
        # Get the raw text of the file
        $raw = Get-Content -Path $File
    
        # Looking for any Constructors
        foreach ($l in $raw) {
            #Constructors contain the class name... lets see if we can find them
            # Checking for blank lines
            if ($l.Equals('') -eq $true){
                Continue
            } 
    
            # Checking for comments
            if ($l.StartsWith('#') -eq $true) {
                # Found a comment line, skip
                Continue
            }
    
            # Checking for class name
            if ( $l.StartsWith('class') -eq $true ) {
                $words = $l.Split(' ')
                $ClassName = $words[1]
                Continue
            }
    
            # Checking for Constructors
            if ( $l.Contains($ClassName) -eq $true ) {
                $Constructors += Get-Constructor -Line $l -ClassName $ClassName
                Continue
            }
    
            # Check for Methods
            if ( $l.Contains('[') -and $l.Contains(']') -and $l.Contains('(') -and $l.Contains(')') -and $l.Contains('{') -eq $true) {
                $Methods += Get-Method -Line $l
                Continue
            }

            

            # Check for Properties
            if ($l.Contains('[') -and $l.Contains(']') -and $l.Contains('$') -eq $true){
                if ($l.Contains($ClassName) -eq $true ){
                    Continue
                }

                # Check for .net calls being returned to vars
                $t = $l
                if ($t.TrimStart().StartsWith('$') -eq $true){
                    Continue
                }

                $Properties += Get-Properties -Line $l
                Continue
            }
    

    
        }
    

        Write-host "hi dad im done"
        # Generate our output file at the end once we picked over the file
        #New-Item -Path $OutputFolder -Name $info.Name | Out-Null
    
    }

    }
}