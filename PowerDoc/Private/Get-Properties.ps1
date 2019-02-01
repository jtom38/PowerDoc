
function Get-Properties {
    param (
        [string] $Line
    )
 
    Process{

        if ( $Line.Contains('hidden ') -eq $true) {
            #Ignore Hidden
            return $null
        }

        if ( $Line.Contains('{')) {
            Return $null
        }

        if ( $Line.Contains('if')-eq $true ) {
            return $null
        }

        if ( $Line.Contains('#') -eq $true ) {
            return $null
        }

        if ($Line.Contains('::') -eq $true){
            return $null
        }

        if ($Line.Contains('=') -eq $true) {
            return $null
        }

        if ($Line.Contains('[') -and `
            $Line.Contains(']') -and `
            $Line.Contains('$') -eq $true){

            # Check for .net calls being returned to vars
            $t = $Line
            if ($t.TrimStart().StartsWith('$') -eq $true){
                Continue
            }

            $Line = $Line
            $Line = $Line.TrimStart()
            return $Line
        } 
    }
}