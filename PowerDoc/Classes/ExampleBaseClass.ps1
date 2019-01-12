
class ExampleBaseClass {

    ExampleBaseClass(){
        throw "I am a base class and can not be instanced."
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