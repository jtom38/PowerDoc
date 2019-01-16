<#
.Synopsis 
This takes the information tha was sent and builds a markdown file.

.Description
This is a private function so it is not exposed.

.Parameter Class
[Switch] Flag to tell the function that we are working with Class data.

.Parameter ClassName
[string] Lets the process know what to name the file and alo what the header will be.

.Parameter BaseClasses
[string[]] Defines the base classes that where tied to the class.

.Parameter Constructors
[string[]] Defines all the Constructors that where attached with the class.

.Parameter Properties
[string[]] Defines all the Properites that where attached to the class.

.Parameter Methods
[string[]] Defines all the Methods that where attached to the class.

.Parameter Function
[switch] Flag to let the function know to look at Function data.

.Parameter FunctionName
[string] Lets the process know what to name the file and alo what the header will be.

.Parameter HelpDocs
[PSObject] Contains all the information that was exposed with the Get-Help $FunctionName.

.Outputs
[void]

.Example
Export-ToMarkdown -Class -Class "ClassName" -BaseClasses $BaseClasses -Constructor $Contructors
Export-ToMarkdown -Function -FunctionName "Start-PowerDoc" -HelpDocs Get-Help Start-PowerDoc
#>

function Export-ToMarkdown {
    param (

        [switch] $Class,        
        [string] $ClassName,
        [string[]] $BaseClasses,
        [string[]] $Constructors,
        [string[]] $Properties,
        [string[]] $Methods,
        [hashtable] $ClassHelp,

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
            $export = "$($path)$($name)"

            if ( [System.IO.File]::Exists($export) -eq $true ) {
                [System.IO.File]::Delete($export)
            }
            New-Item -Name $name -Path $path | Out-Null
            
            # Start building md file
            # Insert class name
            Add-Content -Path $export -Value "# $ClassName"
            Add-Content -Path $export -Value ''
            
            if ( $ClassHelp -ne ""){
                Add-Content -Path $export -Value '## Help Documentation'
                Add-Content -Path $export -Value ''
                # Import what we got from the Help Template
                foreach( $k in $ClassHelp.GetEnumerator() ){
                    Add-Content -Path $export -Value "### $($K.key)"
                    Add-Content -Path $export -Value ''

                    foreach ($item in $k.Value){
                        Add-Content -Path $export -Value "$item"
                    }
                    Add-Content -Path $export -Value ''
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

            Write-Host "Export of [$($ClassName).md] is finished." -ForegroundColor Green

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
            Add-Content -Path $export -Value "Generated by [PowerDoc](https://github.com/luther38/PowerDoc)"
            Add-Content -Path $export -Value "Last updated: $dt"

            Write-Host "Export of [$($FunctionName).md] is finished." -ForegroundColor Green
        }
    }

}