
. .\PowerDoc\Private\Get-BaseClasses.ps1

Describe "[Function] Get-BaseClasses" {

    it -Name "Checking against two base classes: " {
        $t = "class ExampleClass : ExampleBaseClass, FakeClass {"
        $result = Get-BaseClasses -Line $t
        $result.length | Should -Be 2
    }

    it -Name "Checking against a single base class:" {
        $t = "class ExampleClass : ExampleBaseClass {"
        $result = Get-BaseClasses -Line $t
        $result | Should -Be "ExampleBaseClass"
    }

    it -Name "Checking against no base classes:" {
        $t = "class ExampleClass {"
        $result = Get-BaseClasses -Line $t
        $result | Should -Be $null
    }

}