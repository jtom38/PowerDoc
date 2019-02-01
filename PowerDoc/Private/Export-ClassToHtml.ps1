function Export-ClassToHtml {
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
                Write-Host " [x] $($ClassName).html failed to generate.  No documentation was found to extract." -ForegroundColor Red
                Continue
        }

        $dt = [datetime]::Now.ToShortDateString()        

        # Generate HTML file
        $name = "$($ClassName).html"
        $path = "$($Global:PowerDoc.PathOutput)\"
        $export = "$($path)$($name)"

        if ( [System.IO.File]::Exists($export) -eq $true ) {
            [System.IO.File]::Delete($export)
        }
        New-Item -Name $name -Path $path | Out-Null
                
        # Start building html file
        # If we have Base Classes, export
        Add-Content -Path $export -Value "<h1>$ClassName</h1>"
        Add-Content -Path $export -Value "<hr>"

        if ( $ClassHelp.Values.Count -ge 1) {
            # This will be processed if we found help docs to extract

            Add-Content -Path $export -Value '<h2>Help Documentation</h2>'
            Add-Content -Path $export -Value '<br>'

            # Check for .Synopsis
            foreach( $k in $ClassHelp.GetEnumerator() ){            
                if( $k.key.ToLower().Contains("synopsis")){
                    Add-Content -Path $export -Value "<h3>$($K.key)</h3>"                
    
                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item"
                    }
                    Add-Content -Path $export -Value '<br><br>'
                }
            }

            # Check for .Synopsis
            foreach( $k in $ClassHelp.GetEnumerator() ){            
                if( $k.key.ToLower().Contains("synopsis")){
                    Add-Content -Path $export -Value "<h3>$($K.key)</h3>"                    
    
                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item"
                    }
                    Add-Content -Path $export -Value '<br><br>'
                }
            }

            # Check for .Description
            foreach( $k in $ClassHelp.GetEnumerator() ){            
                if( $k.key.ToLower().Contains("description")){
                    Add-Content -Path $export -Value "<h3>$($K.key)</h3>"
    
                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item"
                    }
                    Add-Content -Path $export -Value '<br><br>'
                }
            }

            # Check for .Parameter
            foreach( $k in $ClassHelp.GetEnumerator() ){
                if( $k.key.ToLower().Contains("parameter ")){
                    Add-Content -Path $export -Value "<h3>$($K.key)</h3>"
    
                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item`r`n"
                    }
                    Add-Content -Path $export -Value '<br><br>'
                }
            }

            # Check for .Outputs
            foreach( $k in $ClassHelp.GetEnumerator() ){
                if( $k.key.ToLower().Contains("outputs")){
                    Add-Content -Path $export -Value "<h3>$($K.key)</h3>"
    
                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item`r`n"
                    }
                    Add-Content -Path $export -Value '<br><br>'
                }
            }

            # Check for .Example
            foreach( $k in $ClassHelp.GetEnumerator() ){
                if( $k.key.ToLower().Contains("example")){
                    Add-Content -Path $export -Value "<h3>$($K.key)</h3>"
    
                    Add-Content -Path $export -Value '<code>'
                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item`r`n"
                    }
                    Add-Content -Path $export -Value '</code>'
                    Add-Content -Path $export -Value '<br><br>'
                }
            }
        }

        Add-Content -Path $export -Value '<h2>Class Documentation</h2>'
        Add-Content -Path $export -Value '<br>'
        if ( [System.String]::IsNullOrEmpty($BaseClasses) -eq $false) {                
            Add-Content -Path $export -Value "<h3>Base Classes</h3>"
            Add-Content -Path $export -Value ''
            Add-Content -Path $export -Value '<code>'
            foreach( $i in $BaseClasses){
                Add-Content -Path $export -Value "$i </br>"                    
            }
            Add-Content -Path $export -Value '</br>'
            Add-Content -Path $export -Value '</code>'
            Add-Content -Path $export -Value ''                
        }

        if ( [System.String]::IsNullOrEmpty($Constructors) -eq $false ) {                
            Add-Content -Path $export -Value "<h3>Constructors</h3>"
            Add-Content -Path $export -Value ''
            Add-Content -Path $export -Value '<code>'
            foreach( $i in $Constructors){
                Add-Content -Path $export -Value "$i </br>"                    
            }
            Add-Content -Path $export -Value '</br>'
            Add-Content -Path $export -Value '</code>'
            Add-Content -Path $export -Value ''                
        }
        
        if ( [System.String]::IsNullOrEmpty($Properties) -eq $false ) {                
            Add-Content -Path $export -Value "<h3>Properties</h3>"
            Add-Content -Path $export -Value ''
            Add-Content -Path $export -Value '<code>'
            foreach( $i in $Properties){
                Add-Content -Path $export -Value "$i </br>"                    
            }
            Add-Content -Path $export -Value "</br>"
            Add-Content -Path $export -Value '</code>'
            Add-Content -Path $export -Value ''
        }

        if ( [System.String]::IsNullOrEmpty($Methods) -eq $false ) {            
            Add-Content -Path $export -Value "<h3>Methods</h3>"
            Add-Content -Path $export -Value ''
            Add-Content -Path $export -Value '<code>'
            foreach( $i in $Methods){
                Add-Content -Path $export -Value "$i </br>"                    
            }
            Add-Content -Path $export -Value "</br>"
            Add-Content -Path $export -Value '</code>'
            Add-Content -Path $export -Value ''
        }

        #Add-Content -Path $export -Value $template
        Add-Content -Path $export -Value "</br>"
        Add-Content -Path $export -Value "Generated by <a href='https://github.com/luther38/PowerDoc'>PowerDoc</a></br>"
        Add-Content -Path $export -Value "Last updated: $($dt)"

        Write-Host " [o] $($ClassName).html is finished generating" -ForegroundColor Green
    }
    
}