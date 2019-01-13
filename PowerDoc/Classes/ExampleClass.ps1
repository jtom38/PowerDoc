
# This is a example clas to show how the files get parced
class ExampleClass : ExampleBaseClass, FakeClass {
    
    ExampleClass(){
        
    }

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