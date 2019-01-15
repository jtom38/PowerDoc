<#
.Synopsis
Extracts method information from a line.

.Description
This is a private function that will not be exposed.

.Parameter Line
[string] This contains the line of data that we will look at amd extract method information.

.Example
Get-Methop -Line $Line

.Outputs
[string]
#>
function Get-Method {
    param (
        [string] $Line
    )
    
    Process{

        if ( $l.Contains('[') -and $l.Contains(']') -and $l.Contains('(') -and $l.Contains(')') -and $l.Contains('{') -eq $true) {
            $l = $Line
            $l = $l.TrimStart()
            $l = $l.Replace('{', '')
            $l = $l.TrimEnd()
    
            return $l
            Continue
        }
    }
}