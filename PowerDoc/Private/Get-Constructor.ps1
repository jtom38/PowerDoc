

function Get-Constructor {
    param (
        [string] $line,
        [string] $ClassName
    )

    Process {
        
        $t = $line

        # Check for blank Constructor
        if ( $t.Contains('()') -eq $true) {                
            # Remove Whitespace
            $t = $t.TrimStart()
            $t = $t.Replace('{','')
            $t = $t.TrimEnd()
            return $t
        }

        # Check for Constructors with Variables
        if ( $t.Contains('[') -and $t.Contains(']') -eq $true) {
            $t = $t.TrimStart()
            $t = $t.Replace('{','')
            $t = $t.TrimEnd()
            return $t
        }
    }   
}