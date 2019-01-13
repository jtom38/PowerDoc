function ConvertTo-Markdown {
    param (

        [switch] $Class,
        [string] $FileName,
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
            $name = "$($ClassName).md"
            $path = "$($Global:PowerDoc.PathOutput)\"
            New-Item -Name $name -Path $path | Out-Null

            $export = "$($path)$($name)"
            
            # Start building md file
            # Insert class name
            Add-Content -Path $export -Value "# $ClassName"
            Add-Content -Path $export -Value ''
            
            # If we have Base Classes, export
            if ( [System.String]::IsNullOrEmpty($BaseClasses) -eq $false) {
                Add-Content -Path $export -Value "## Base Classes"
                Add-Content -Path $export -Value ''
                foreach( $i in $BaseClasses){
                    Add-Content -Path $export -Value "$i"                    
                }                
                Add-Content -Path $export -Value ''
            }

            if ( [System.String]::IsNullOrEmpty($Constructors) -eq $false ) {
                Add-Content -Path $export -Value "## Constructors"
                Add-Content -Path $export -Value ''
                Add-Content -Path $export -Value '```PowerShell'
                foreach( $i in $Constructors){
                    Add-Content -Path $export -Value "$i"                    
                }
                Add-Content -Path $export -Value '```'
                Add-Content -Path $export -Value ''
            }
            
            if ( [System.String]::IsNullOrEmpty($Properties) -eq $false ) {
                Add-Content -Path $export -Value "## Properties"
                Add-Content -Path $export -Value ''
                Add-Content -Path $export -Value '```PowerShell'
                foreach( $i in $Properties){
                    Add-Content -Path $export -Value "$i"                    
                }
                Add-Content -Path $export -Value '```'
                Add-Content -Path $export -Value ''
            }

            if ( [System.String]::IsNullOrEmpty($Methods) -eq $false ) {
                Add-Content -Path $export -Value "## Methods"
                Add-Content -Path $export -Value ''
                Add-Content -Path $export -Value '```PowerShell'
                foreach( $i in $Methods){
                    Add-Content -Path $export -Value "$i"                    
                }
                Add-Content -Path $export -Value '```'
                Add-Content -Path $export -Value ''
            }

            Add-Content -Path $export -Value "Generated by [PowerDoc](https://github.com/luther38/PowerDoc) @ $($dt)"

            <#
            foreach($line in $Template){
                Add-Content -Path $export -Value $line
            }
            #>

            Write-Host "Export of [$($ClassName).md] is finished."

        }

        if ( $Function -eq $true) {
            $dt = [datetime]::Now.ToShortDateString()        

            # Generate Markdown file
            $name = "$($FunctionName).md"
            $path = "$($Global:PowerDoc.PathOutput)\"
            New-Item -Name $name -Path $path | Out-Null

            $export = "$($path)$($name)"
            
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
                    
                    Add-Content -Path $export -Value "Type: $($param.Type.Name)  return"
                    Add-Content -Path $export -Value "Required: $($param.Required)  return"
                    Add-Content -Path $export -Value "Globbing: $($param.Globbing)  return"
                    Add-Content -Path $export -Value "PipelineInput: $($param.PipelineInput)  return"
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
            
        }
    }

}