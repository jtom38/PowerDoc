
function Get-ClassHelp {
    param (
        [string] $PathClassFile
    )
    
    Process{
        $class = Get-Content -Path $PathClassFile

        $CommentBlock = $false
        $hash = @{}
        $lastBlock = ""
        $Comment = @()
        
        foreach ( $l in $class){
        
            if ($l -eq ""){ Continue }
        
            if ( $l.Contains('<#') -eq $true) {
                $CommentBlock = $true
                Continue
            }
        
            if ( $l.Contains('#>') -eq $true) {
                if ($lastBlock -ne ""){
                    $hash.Add($lastBlock, $Comment)
                    $lastBlock = ""
                    $Comment = @()
                }
        
                $CommentBlock = $false
                # We are done looking at the notes block, Return our hash
                return $hash
            }
        
            if ( $CommentBlock -eq $true -and $l.StartsWith('.') -eq $true ) {
        
                if ( $lastBlock -ne ""){
                    #Write our info to the hash
                    $hash.Add($lastBlock, $Comment)
                    $lastBlock = ""
                    $Comment = @()
                }
        
                #Make note of the block we are on
                if ($l.StartsWith('.') -eq $true) {
                    $l = $l.Replace('.', '')
                    $lastBlock = $l
                    continue
                }
            }
        
            if ( $CommentBlock -eq $true -and $lastBlock -ne ""){
                # capture the text 
                $Comment += $l
                Continue
            }
        }

        return $hash
    }
}