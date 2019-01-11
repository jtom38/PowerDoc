function ConvertTo-Markdown {
    param (
        # Class Param
        [string] $FileName,
        [string] $ClassName,
        [string[]] $Constructors,
        [string[]] $Properties,
        [string[]] $Methods

        # Function Param

    )
    
    Process {

        if ([System.String]::IsNullOrEmpty($ClassName) -eq $false -and
            [System.String]::IsNullOrEmpty($FileName) -eq $false -and
            [System.String]::IsNullOrEmpty($Constructors) -eq $false -and 
            [System.String]::IsNullOrEmpty($Properties) -eq $false -and
            [System.String]::IsNullOrEmpty($Methods) -eq $false ) {

            # Generate Markdown file

        }

    }

}