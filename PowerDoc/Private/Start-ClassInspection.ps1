<#
.Synopsis
This is the process that will read all the lines from a class file and extract important information.

.Description
This is a private function that will not be exposed.
Each line of the file that is loaded will be looked at for spicifc notes.
If the line contains data that is needed it will be stored.
Once the file has been processed it will be sent over to be converted into a file to be used as documentation.

.Parameter File
[string] This contains the full or relative path to the file that needs to be inspected.

.Parameter Markdown
[swtich] Flag to let the function know that markdown is requested file type as export.

.Parameter Html
[swtich] Flag to let the function know that html is requested file type as export.

.Example
Start-ClassInspection -File ".\src\file.ps1" -Markdown
Start-ClassInspection -File ".\src\file.ps1" -Html

.Outputs
[void]

#>
function Start-ClassInspection {
    param (
        [string] $File,
        [switch] $Markdown,
        [switch] $Html
    )
    
    Process {
        
        if ([System.String]::IsNullOrEmpty($File) -eq $false) {
        
            $ClassName = ''
            $BaseClasses = @()
            $Constructors = @()
            $Properties = @()
            $Methods = @()
        
            $info = [System.IO.FileInfo]::new($File)
            
            # Get the raw text of the file
            $raw = Get-Content -Path $File
        
            [hashtable] $help = Find-HelpDocs -PathFile $info.FullName

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

                # Check for Hidden Properties/Methods
                if ( $l.Contains('hidden ')){
                    Continue
                }
        
                if ( $l.Contains('static ')) {

                }

                # Checking for class name
                if ( $l.StartsWith('class') -eq $true ) {

                    # Check if we had base classes
                    if ( $l.Contains(':') -eq $true) {
                        $BaseClasses += Get-BaseClasses -Line $l
                    }

                    # Extracts the class Name
                    $words = $l.Split(' ')
                    $ClassName = $words[1]
                    Continue
                }
        
                # Checking for Constructors
                if ( $l.Contains($ClassName) -eq $true ) {
                    $ConstructorResult = Get-Constructor -Line $l -ClassName $ClassName
                    if ( [System.String]::IsNullOrEmpty($ConstructorResult) -eq $false) {
                        $Constructors += $ConstructorResult
                    }            
                    Continue
                }
        
                # Check for Methods
                $methodResult = Get-Method -Line $l
                if ( [System.String]::IsNullOrEmpty($methodResult) -eq $false ) {
                    $Methods += $methodResult
                    Continue
                }                

                # Check for Properties
                $propResult = Get-Properties -Line $l
                if( [System.String]::IsNullOrEmpty($propResult) -eq $false) {
                    $Properties += $propResult
                }  
            }

            # Generate our output file at the end once we picked over the file
            
            if ( $Markdown -eq $true ) {
                Export-ClassToMarkdown -FileName $info.Name -ClassName $ClassName -Constructors $Constructors -Properties $Properties -Methods $Methods -BaseClasses $BaseClasses -ClassHelp $help
            }

            if ( $Html -eq $true) {
                Export-ClassToHtml -FileName $info.Name -ClassName $ClassName -Constructors $Constructors -Properties $Properties -Methods $Methods -BaseClasses $BaseClasses -ClassHelp $help
            }        
        }
    }

}