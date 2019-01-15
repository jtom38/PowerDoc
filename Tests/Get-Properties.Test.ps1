
. .\PowerDoc\Private\Get-Properties.ps1

Describe "[Function] Get-Properties" {

    it "Should not find a class:"{
        $t = 'ClassName'
        $result = Get-Properties -Line $t 
        $result | Should -Be $null
    }

    it "Should not find a method in a Constructor:" {
        $t = 'ClassName(){'
        $result = Get-Properties -Line $t 
        $result | Should -Be $null
    }

    it "Should not find a method in a overloaded Constructor:" {
        $t = 'ClassName([string] $val){'
        $result = Get-Properties -Line $t 
        $result | Should -Be $null
    }

    it "Should find a property:" {
        $t = '[string] $Prop'
        $result = Get-Properties -Line $t 
        $result | Should -Be '[string] $Prop'
    }

    it "Should not find a hidden property:" {
        $t = 'hidden [string] $Prop'
        $result = Get-Properties -Line $t 
        $result | Should -Be $null
    }

    it "Should find a static property" {
        $t = 'static [string] $Prop'
        $result = Get-Properties -Line $t 
        $result | Should -Be 'static [string] $Prop'
    }

    it "Should not find a hidden method:"{
        $t = 'hidden [void] Method(){'
        $result = Get-Properties -Line $t 
        $result | Should -Be $null
    }

    it "Should not find a static method:"{
        $t = 'static [void] Method(){'
        $result = Get-Properties -Line $t 
        $result | Should -Be $null
    }

    it "Should not find a void method:" {
        $t = '[void] Method(){'
        $result = Get-Properties -Line $t 
        $result | Should -Be $null
    }

    it "Should not find a void method with one overload:"{
        $t = '[void] Method([string] $val){'
        $result = Get-Properties -Line $t 
        $result | Should -Be $null
    }
}