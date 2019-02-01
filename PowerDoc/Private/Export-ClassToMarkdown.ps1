
function Export-ClassToMarkdown {
    param (
        [string] $ClassName,
        [string[]] $BaseClasses,
        [string[]] $Constructors,
        [string[]] $Properties,
        [string[]] $Methods,
        [hashtable] $ClassHelp
    )
    
    Process {

        if( $BaseClasses.Count -eq 0 -and
            $Constructors.Count -eq 0 -and
            $Properties.Count -eq 0 -and 
            $Methods.Count -eq 0 -and
            $ClassHelp.Count -eq 0) {
                Write-Host " [x] $($ClassName).md failed to generate.  No documentation was found to extract." -ForegroundColor Red
                Continue
        }

        $dt = [datetime]::Now.ToShortDateString()        

        # Generate Markdown file
        $name = "$($ClassName).md"
        $path = "$($Global:PowerDoc.PathOutput)\"
        $export = "$($path)$($name)"

        if ( [System.IO.File]::Exists($export) -eq $true ) {
            [System.IO.File]::Delete($export)
        }
        New-Item -Name $name -Path $path | Out-Null
        
        # Start building md file
        # Insert class name
        Add-Content -Path $export -Value "# $ClassName"
        Add-Content -Path $export -Value ''
        
        if ( $ClassHelp.Values.Count -ge 1) {
            # This will be processed if we found help docs to extract

            Add-Content -Path $export -Value '## Help Documentation'
            Add-Content -Path $export -Value ''

            foreach( $k in $ClassHelp.GetEnumerator() ){
                if( $k.key.ToLower().Contains("synopsis")){
                    Add-Content -Path $export -Value "## $($K.key)"
                    Add-Content -Path $export -Value ''
    
                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item"
                    }
                    Add-Content -Path $export -Value ''
                }
            }

            # Check for .Description
            foreach( $k in $ClassHelp.GetEnumerator() ){            
                if( $k.key.ToLower().Contains("description")){
                    Add-Content -Path $export -Value "## $($K.key)"
                    Add-Content -Path $export -Value ''
    
                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item"
                    }
                    Add-Content -Path $export -Value ''
                }
            }

            # Check for .Parameter
            foreach( $k in $ClassHelp.GetEnumerator() ){
                if( $k.key.ToLower().Contains("parameter ")){
                    Add-Content -Path $export -Value "## $($K.key)"
                    Add-Content -Path $export -Value ''
    
                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item`r`n"
                    }
                    Add-Content -Path $export -Value ''
                }
            }

            # Check for .Outputs
            foreach( $k in $ClassHelp.GetEnumerator() ){
                if( $k.key.ToLower().Contains("outputs")){
                    Add-Content -Path $export -Value "## $($K.key)"
                    Add-Content -Path $export -Value ''
    
                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item`r`n"
                    }
                    Add-Content -Path $export -Value ''
                }
            }

            # Check for .Example
            foreach( $k in $ClassHelp.GetEnumerator() ){
                if( $k.key.ToLower().Contains("example")){
                    Add-Content -Path $export -Value "## $($K.key)"
                    Add-Content -Path $export -Value ''
    
                    Add-Content -Path $export -Value '```PowerShell'
                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item`r`n"
                    }
                    Add-Content -Path $export -Value '```'
                    Add-Content -Path $export -Value ''
                }
            }
        }

        # If we have Base Classes, export
        Add-Content -Path $export -Value '## Class Documentation'
        Add-Content -Path $export -Value ''
        if ( [System.String]::IsNullOrEmpty($BaseClasses) -eq $false) {
            Add-Content -Path $export -Value "### Base Classes"
            Add-Content -Path $export -Value ''
            Add-Content -Path $export -Value '```PowerShell'
            foreach( $i in $BaseClasses){
                Add-Content -Path $export -Value "$i"                    
            }
            Add-Content -Path $export -Value '```'
            Add-Content -Path $export -Value ''
        }

        if ( [System.String]::IsNullOrEmpty($Constructors) -eq $false ) {
            Add-Content -Path $export -Value "### Constructors"
            Add-Content -Path $export -Value ''
            Add-Content -Path $export -Value '```PowerShell'
            foreach( $i in $Constructors){
                Add-Content -Path $export -Value "$i"                    
            }
            Add-Content -Path $export -Value '```'
            Add-Content -Path $export -Value ''
        }
        
        if ( [System.String]::IsNullOrEmpty($Properties) -eq $false ) {
            Add-Content -Path $export -Value "### Properties"
            Add-Content -Path $export -Value ''
            Add-Content -Path $export -Value '```PowerShell'
            foreach( $i in $Properties){
                Add-Content -Path $export -Value "$i"                    
            }
            Add-Content -Path $export -Value '```'
            Add-Content -Path $export -Value ''
        }

        if ( [System.String]::IsNullOrEmpty($Methods) -eq $false ) {
            Add-Content -Path $export -Value "### Methods"
            Add-Content -Path $export -Value ''
            Add-Content -Path $export -Value '```PowerShell'
            foreach( $i in $Methods){
                Add-Content -Path $export -Value "$i"                    
            }
            Add-Content -Path $export -Value '```'
            Add-Content -Path $export -Value ''
        }

        Add-Content -Path $export -Value "Generated by [PowerDoc](https://github.com/luther38/PowerDoc)"
        Add-Content -Path $export -Value "Last updated: $dt"

        Write-Host " [o] Finished generating $($ClassName).md" -ForegroundColor Green

    }
}