
<#
.Synopsis
Function that extracts information from a line that contains a Constructor

.Description
This is a private function that will not be exposed.

.Parameter Line
[string] This contains the line that will be extracted from to return a Constructor.

.Parameter ClassName
[string] Defines that class name that we will match against for a Constructor

.Example
Get-Constructor -Line $Line -ClassName "Cookie"

.Outputs
[string]

#>
function Get-Constructor {
    param (
        [string] $Line,
        [string] $ClassName
    )

    Process {
        
        #$Line = $line

        if ( $Line.Contains('hidden ') -eq $true ) {
            Continue
        }

        if ( $Line.Contains('::new') -eq $true ) {
            Continue
        }

        # Check for blank Constructor
        if ( $Line.Contains($ClassName) -and $Line.Contains('()') -eq $true) {                
            # Remove Whitespace
            $Line = $Line.TrimStart()
            $Line = $Line.Replace('{','')
            $Line = $Line.TrimEnd()
            return $Line
        }

        # Check for Constructors with Variables
        if ( $Line.Contains($ClassName) -and $Line.Contains('(') -and $Line.Contains(')') -and $Line.Contains('[') -and $Line.Contains(']') -eq $true) {
            $Line = $Line.TrimStart()
            $Line = $Line.Replace('{','')
            $Line = $Line.TrimEnd()
            return $Line
        }

        return Continue
    }   
}