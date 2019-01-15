
. .\PowerDoc\Private\Get-Method.ps1

Describe "[Function] Get-Method"{

    it "Should not find a class:"{
        $t = 'ClassName'
        $result = Get-Method -Line $t 
        $result | Should -Be $null
    }

    it "Not find a method in a Constructor:" {
        $t = 'ClassName(){'
        $result = Get-Method -Line $t 
        $result | Should -Be $null
    }

    it "Should not find a property:" {
        $t = '[string] $Prop'
        $result = Get-Method -Line $t 
        $result | Should -Be $null
    }

    it "Should not find a hidden method:"{
        $t = 'hidden [void] Method(){'
        $result = Get-Method -Line $t 
        $result | Should -Be $null
    }

    it "Should find a static method:"{
        $t = 'static [void] Method(){'
        $result = Get-Method -Line $t 
        $result | Should -Be 'static [void] Method()'
    }

    it "Should find a void method:" {
        $t = '[void] Method(){'
        $result = Get-Method -Line $t 
        $result | Should -Be '[void] Method()'
    }

    it "Should find a void method with one overload:"{
        $t = '[void] Method([string] $val){'
        $result = Get-Method -Line $t 
        $result | Should -Be '[void] Method([string] $val)'
    }
}