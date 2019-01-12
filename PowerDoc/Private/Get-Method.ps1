
function Get-Method {
    param (
        [string] $Line
    )
    
    Process{

        $l = $Line
        $l = $l.TrimStart()
        $l = $l.Replace('{', '')
        $l = $l.TrimEnd()

        return $l
    }
}