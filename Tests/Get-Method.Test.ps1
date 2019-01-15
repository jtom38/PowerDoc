
. .\PowerDoc\Private\Get-Method.ps1

Describe "[Function] Get-Method"{

    it "Should not find a class:"{

    }

    it "Not find a method in a Constructor:" {
        $t = "TestClass(){"
        $result = Get-Method -Line $t 
        $result | Should -Be $null
    }

    it "Should not find a property:" {

    }

    it "Should not find a hidden method:"{

    }

    it "Should find a void method:" {

    }

    it "Should find a void method with one overload:"{
        
    }
}