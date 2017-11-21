$ModuleManifestName = 'posh-cats.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"

Describe 'Module Manifest' {
    It 'Should be a valid ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath | Should -Not -BeNullOrEmpty
        $? | Should Be $true
    }
}

InModuleScope posh-cats {


    Describe "Get-CatName" {

        Context "When call: Get-CatName" {
            Mock LoadCatNames { return "Juca" }
            $result = Get-CatName

            It "Should return a single name" {
                $result | Should -Be "Juca"
            }
        }

        Context "When call: Get-CatName -All" {
            $result = Get-CatName -All

            It "Should return 100 names" {
                $result.Count | Should -Be 100
                $result[0] | Should -Be "Abby"
                $result[99] | Should -Be "Zoey"
            }
        }
    }


    Describe "Get-CatEmoji" {

    }

    Describe "Get-CatBuzz" {

    }

    Describe "Get-CatImage" {

    }

    Describe "Get-CatMeowYoutubeMix" {

    }

    Describe "Get-CatMeow" {

    }

    Describe "Get-CatBabyMeow" {

    }

    Describe "Get-CatFight" {

    }

    Describe "Get-CatAngry" {

    }

    Describe "Get-CatPurr" {

    }

    Describe "Get-CatYowl" {

    }
}