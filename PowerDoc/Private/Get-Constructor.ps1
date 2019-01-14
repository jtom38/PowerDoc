
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
        [string] $line,
        [string] $ClassName
    )

    Process {
        
        $t = $line

        # Check for blank Constructor
        if ( $t.Contains($ClassName) -and $t.Contains('()') -eq $true) {                
            # Remove Whitespace
            $t = $t.TrimStart()
            $t = $t.Replace('{','')
            $t = $t.TrimEnd()
            return $t
        }

        # Check for Constructors with Variables
        if ( $t.Contains($ClassName) -and $t.Contains('(') -and $t.Contains(')') $t.Contains('[') -and $t.Contains(']') -eq $true) {
            $t = $t.TrimStart()
            $t = $t.Replace('{','')
            $t = $t.TrimEnd()
            return $t
        }
    }   
}