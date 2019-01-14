<#
.Synopsis
Extracts the base classes that where attached to a class.

.Description
This is a private function that will not be exposed.

.Parameter Line
[string] This is the line of data that will be looked at and extracted from.

.Example
Get-BaseClasses -Line $LineData

.Outputs
Returns either [string] or [string[]] depending on data found. 
#>

function Get-BaseClasses {
    param (
        [string] $Line
    )
    
    Process {
        # Get the Class Name
        $BaseClasses = @()
        $l = $Line

        if ( $l.Contains(':') -and $l.Contains(',') -eq $true) {

            $l = $l.Remove(0, $l.IndexOf(':')+1) 

            $words = $l.Split(',')                        
            foreach ($w in $words){
                
                $w = $w.TrimStart()
                $w = $w.Replace('{', '')
                $w = $w.TrimEnd()
                
                $BaseClasses += $w
            }
            return $BaseClasses
        }

        if ( $l.Contains(':') -eq $true ) {

            $l = $l.Remove(0, $l.IndexOf(':')+1)
            
            $l = $l.TrimStart()
            $l = $l.Replace('{', '')
            $l = $l.TrimEnd()

            return $l
        }

    }
}