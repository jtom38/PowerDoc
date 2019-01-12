
function Get-Properties {
    param (
        [string] $Line
    )
 
    Process{

        $l = $Line
        $l = $l.TrimStart()
        return $l

    }
}