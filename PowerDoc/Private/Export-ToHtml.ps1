
function Export-ToHtml {
    param (
        [switch] $Class,        
        [string] $ClassName,
        [string[]] $BaseClasses,
        [string[]] $Constructors,
        [string[]] $Properties,
        [string[]] $Methods,

        [switch] $Function,
        [string] $FunctionName,
        [psobject] $HelpDocs
    )
    
    Process {

        if ( $Class -eq $true ) {
            $dt = [datetime]::Now.ToShortDateString()        

            # Generate Markdown file
            $name = "$($ClassName).html"
            $path = "$($Global:PowerDoc.PathOutput)\"
            New-Item -Name $name -Path $path | Out-Null

            $export = "$($path)$($name)"
            
            $template = Get-Content -Path ".\PowerDoc\Private\basicTemplate.html"
            $template = $template.Replace('{Name}', $ClassName)

            # Start building html file
            
            # If we have Base Classes, export
            if ( [System.String]::IsNullOrEmpty($BaseClasses) -eq $false) {
                <#
                Add-Content -Path $export -Value "<h2>Base Classes</h2>"
                Add-Content -Path $export -Value ''
                Add-Content -Path $export -Value '<code>'
                foreach( $i in $BaseClasses){
                    Add-Content -Path $export -Value "$i </br>"                    
                }
                Add-Content -Path $export -Value '</br>'
                Add-Content -Path $export -Value '</code><hr>'
                Add-Content -Path $export -Value ''
                #>

                $bc = ""            
                foreach( $i in $BaseClasses){
                    $bc += "$i <br>"
                }
                $template = $template.Replace("{BaseClasses}", $bc)
            }
            else {
                $template = $template.Replace("{BaseClasses}", "None")
            }

            if ( [System.String]::IsNullOrEmpty($Constructors) -eq $false ) {
                <#
                Add-Content -Path $export -Value "<h2>Constructors</h2>"
                Add-Content -Path $export -Value ''
                Add-Content -Path $export -Value '<code>'
                foreach( $i in $Constructors){
                    Add-Content -Path $export -Value "$i </br>"                    
                }
                Add-Content -Path $export -Value '</br>'
                Add-Content -Path $export -Value '</code><hr>'
                Add-Content -Path $export -Value ''
                #>

                $con = ""
                foreach( $i in $Constructors){
                    $con += "$i <br>"
                }
                $template = $template.Replace('{Constructors}', $con)
            }else{
                $template = $template.Replace('{Constructors}', "None")
            }
            
            if ( [System.String]::IsNullOrEmpty($Properties) -eq $false ) {
                <#
                Add-Content -Path $export -Value "<h2>Properties</h2>"
                Add-Content -Path $export -Value ''
                Add-Content -Path $export -Value '<code>'
                foreach( $i in $Properties){
                    Add-Content -Path $export -Value "$i </br>"                    
                }
                Add-Content -Path $export -Value "</br>"
                Add-Content -Path $export -Value '</code><hr>'
                Add-Content -Path $export -Value ''
                #>

                $prop = ""
                foreach( $i in $Properties){
                    $prop += "$i <br>"
                }
                $template = $template.Replace('{Properties}', $prop)
            }else{
                $template = $template.Replace('{Properties}', "None")
            }

            if ( [System.String]::IsNullOrEmpty($Methods) -eq $false ) {
                <#
                Add-Content -Path $export -Value "<h2>Methods</h2>"
                Add-Content -Path $export -Value ''
                Add-Content -Path $export -Value '<code>'
                foreach( $i in $Methods){
                    Add-Content -Path $export -Value "$i </br>"                    
                }
                Add-Content -Path $export -Value "</br>"
                Add-Content -Path $export -Value '</code><hr>'
                Add-Content -Path $export -Value ''
                #>

                $m = ""
                foreach ( $i in $Methods){
                    $m += "$i <br>"
                }
                $template = $template.Replace('{Methods}', $m)
            }else{
                $template = $template.Replace('{Methods}', "None")
            }

            Add-Content -Path $export -Value $template
            Add-Content -Path $export -Value "</br>"
            Add-Content -Path $export -Value "Generated by <a href='https://github.com/luther38/PowerDoc'>PowerDoc</a></br>"
            Add-Content -Path $export -Value "Last updated: $($dt)"

            Write-Host "Export of [$($ClassName).html] is finished." -ForegroundColor Green

        }

        if ( $Function -eq $true) {
            $dt = [datetime]::Now.ToShortDateString()        

            # Generate Markdown file
            $name = "$($FunctionName).md"
            $path = "$($Global:PowerDoc.PathOutput)\"
            $export = "$($path)$($name)"

            if ( [System.IO.File]::Exists($export) -eq $true ) {
                [System.IO.File]::Delete($export)
            }

            New-Item -Name $name -Path $path | Out-Null
            
            # Start building md file
            # Insert Function name
            Add-Content -Path $export -Value "# $FunctionName"
            Add-Content -Path $export -Value ''
            
            
            if ($HelpDocs.Synopsis -ne "") {
                Add-Content -Path $export -Value '## Synopsis'
                Add-Content -Path $export -Value ''
                Add-Content -Path $export -Value $HelpDocs.Synopsis
                Add-Content -Path $export -Value ''
            }

            if ($HelpDocs.Description.Count -ge 1 ) {
                Add-Content -Path $export -Value '## Description'
                Add-Content -Path $export -Value ''

                foreach ( $d in $HelpDocs.description) {
                    Add-Content -Path $export -Value $d.Text
                }
                Add-Content -Path $export -Value ''
            }
            
            if ( $HelpDocs.syntax.syntaxItem.parameter.Count -ge 1) {
                Add-Content -Path $export -Value '## Parameters'
                Add-Content -Path $export -Value ''

                foreach ( $param in $HelpDocs.parameters.parameter){
                    Add-Content -Path $export -Value "### -$($param.Name)"
                    Add-Content -Path $export -Value ''
                    foreach ($d in $param.Description) {
                        Add-Content -Path $export -Value $d.Text
                    }
                    
                    Add-Content -Path $export -Value '```PowerShell'
                    Add-Content -Path $export -Value "Type: $($param.Type.Name)"
                    Add-Content -Path $export -Value "Required: $($param.Required)"
                    Add-Content -Path $export -Value "Globbing: $($param.Globbing)"
                    Add-Content -Path $export -Value "PipelineInput: $($param.PipelineInput)"
                    Add-Content -Path $export -Value '```'
                    Add-Content -Path $export -Value ''
                }
                
            }

            if ( $HelpDocs.returnValues.returnValue.type.name -ne "" ) {
                Add-Content -Path $export -Value '## Returns'
                Add-Content -Path $export -Value ''
                Add-Content -Path $export -Value $HelpDocs.returnValues.returnValue.type.name
                Add-Content -Path $export -Value ''
            }

            if ( $HelpDocs.examples.example.Count -ge 1 ) {
                Add-Content -Path $export -Value '## Examples'
                Add-Content -Path $export -Value ''
                Add-Content -Path $export -Value '```PowerShell'
                foreach( $e in $HelpDocs.examples.example ) {                    
                    Add-Content -Path $export -Value $e.Code
                }
                Add-Content -Path $export -Value '```'
                Add-Content -Path $export -Value ''
            }
            Add-Content -Path $export -Value "Generated by [PowerDoc](https://github.com/luther38/PowerDoc) - $($dt)"

            Write-Host "Export of [$($FunctionName).md] is finished." -ForegroundColor Green
        }
    }
}