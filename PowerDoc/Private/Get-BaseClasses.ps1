function Get-BaseClasses {
    param (
        [string] $Line
    )
    
    Process {
        # Get the Class Name
        $BaseClasses = @()

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