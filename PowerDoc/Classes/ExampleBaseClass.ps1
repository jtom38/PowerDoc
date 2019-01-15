<#
.DESCRIPTION
This is a example file

#>
class ExampleBaseClass {

    [string] $Property
    hidden [string] $HiddenProperty

    [void] Method() {

    }

    [void] Method ( [bool] $Overload ) {
        
    }

    hidden HiddenMethod() {

    }

    static StaticMethod() {

    }
}