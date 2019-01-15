
. .\PowerDoc\Private\Get-Constructor.ps1

Describe "[Function] Get-Constructor:" {

    $ClassName = "ClassName"

    it "Should not find a class:"{
        $t = 'class ClassName {'
        $result = Get-Constructor -Line $t 
        $result | Should -Be $null
    }

    it "Should not find a base class:"{
        $t = 'class ClassName : baseclass {'
        $result = Get-Constructor -Line $t 
        $result | Should -Be $null
    }

    it "Should not find two base classes:"{
        $t = 'class ClassName : baseClass, classTwo {'
        $result = Get-Constructor -Line $t 
        $result | Should -Be $null
    }

    It "Should find Constructor with no variables: " {
        $t = 'ClassName(){'
        $result = Get-Constructor -Line $t -ClassName "ClassName"
        $result | Should -Be "ClassName()"
    }

    It "Should find a Constructor with one variable: " {
        $t = 'ClassName([string] $Prop){'
        $result = Get-Constructor -Line $t -ClassName "ClassName"
        $result | Should -Be 'ClassName([string] $Prop)'
    }

    It "Should find a Constructor with two variables: " {
        $t = 'ClassName([string] $Prop, [int] $num){'
        $result = Get-Constructor -Line $t -ClassName "ClassName"
        $result | Should -Be 'ClassName([string] $Prop, [int] $num)'
    }

    it "Should not find a property:" {
        $t = '[string] $Prop'
        $result = Get-Constructor -Line $t -ClassName "ClassName"
        $result | Should -Be $null
    }

    it "Should not find a hidden property:" {
        $t = 'hidden [string] $Prop'
        $result = Get-Constructor -Line $t -ClassName "ClassName"
        $result | Should -Be $null
    }

    it "Should not find a static property" {
        $t = 'static [string] $Prop'
        $result = Get-Constructor -Line $t -ClassName "ClassName"
        $result | Should -Be $null
    }

    it "Should not find a hidden method:"{
        $t = 'hidden [void] Method(){'
        $result = Get-Constructor -Line $t -ClassName "ClassName"
        $result | Should -Be $null
    }

    it "Should not find a static method:"{
        $t = 'static [void] Method(){'
        $result = Get-Constructor -Line $t -ClassName "ClassName"
        $result | Should -Be $null
    }

    it "Should not find a void method:" {
        $t = '[void] Method(){'
        $result = Get-Constructor -Line $t -ClassName "ClassName"
        $result | Should -Be $null
    }

    it "Should not find a void method with one overload:"{
        $t = '[void] Method([string] $val){'
        $result = Get-Constructor -Line $t -ClassName "ClassName"
        $result | Should -Be $null
    }
}