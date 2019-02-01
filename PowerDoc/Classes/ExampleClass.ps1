
<#
.Description
This is a test

.Parameter Property
[string] This is just a filler.

.Example
$class = [ExampleClass]::new()
$class.Method($true)

.Notes
This is line one.
This is line two.

#>

# This is a example class to show how the files get looked at.
class ExampleClass : ExampleBaseClass {
    
    ExampleClass(){
        
    }

    [string] $Property
    hidden [string] $HiddenProperty

    [void] Method() {

    }

    [void] Method ( [bool] $Overload ) {
        
    }

    hidden [void] HiddenMethod() {

    }

    static [void] StaticMethod() {

    }

}