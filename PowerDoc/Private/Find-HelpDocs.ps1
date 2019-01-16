
<#
.Description
This is a function that will assist with extracting the same documenation that you already write for Functions.  

.Parameter PathFile
[string] Pass the full path to your class file.  

.Outputs
You will get a PSObject in the form of a hashtable.

.Example
$hash = Get-ClassHelp -PathFile ".\PowerDoc\Classes\ExampleClass"

#>
function Find-HelpDocs {
    param (
        [string] $PathFile
    )
    
    Process{
        $class = Get-Content -Path $PathFile

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