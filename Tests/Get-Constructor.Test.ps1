
. .\PowerDoc\Private\Get-Constructor.ps1

Describe "[Function] Get-Constructor:" {

    it "Should find no Constructor"{
        $t = '[void] $Prop'

        $result = Get-Constructor -Line $t -ClassName "TestClass"
        $result | Should -Be $null
    }

    It "Should find Constructor with no variables: " {

        $t = 'TestClass(){'
        $result = Get-Constructor -Line $t -ClassName "TestClass"
        $result | Should -Be "TestClass()"
    }

    It "Should find a Constructor with one variable: " {
        $t = 'TestClass([string] $Prop){'
        $result = Get-Constructor -Line $t -ClassName "TestClass"
        $result | Should -Be 'TestClass([string] $Prop)'
    }

    It "Should find a Constructor with two variables: " {
        $t = 'TestClass([string] $Prop, [int] $num){'
        $result = Get-Constructor -Line $t -ClassName "TestClass"
        $result | Should -Be 'TestClass([string] $Prop, [int] $num)'
    }
}