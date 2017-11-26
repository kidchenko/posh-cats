$ModuleRoot = "$PSScriptRoot\.."
$ModuleManifestName = 'posh-cats.psd1'
$ModuleManifestPath = "$ModuleRoot\$ModuleManifestName"

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

        Context "When call: Get-CatEmoji" {
            Mock ConvertUnicodeToString { "🐱" }
            $result = Get-CatEmoji

            It "Should return the cat emoji 🐱" {
                $result | Should -Be "🐱"
            }
        }

        Context "When call: Get-CatEmoji" {
            Mock ConvertUnicodeToString {} -Verifiable -ParameterFilter {
                $unicodeChars -eq "U+1F431"
            }
            $result = Get-CatEmoji

            It "Should convert U+1F431 to Unicode" {
                Assert-MockCalled ConvertUnicodeToString
            }
        }
    }

    Describe "Get-CatBuzz" {
        Context "When call: Get-CatBuzz" {
            Mock OpenPage {} -Verifiable -ParameterFilter {
                "https://www.buzzfeed.com/expresident/best-cat-pictures"
            }

            It "Should open 'Best Cat Pictures' on Buzzfeed" {
                Get-CatBuzz
                Assert-MockCalled OpenPage
            }
        }
    }

    Describe "Get-CatImage" {
        Context "When call: Get-CatImage on Windows" {
            $IsWindows = $true
            Mock OpenPage {} -Verifiable -ParameterFilter {
                "https://thecatapi.com/api/images/get?api_key=MjQyMzQ3"
            }

            It "Should call Cat API using API key" {
                Get-CatImage
                Assert-MockCalled OpenPage
            }
        }

        Context "When call: Get-CatImage on Unix" {
            $IsWindows = $false
            Mock OpenPage {} -Verifiable -ParameterFilter {
                "http://thecatapi.com/api/images/get"
            }

            It "Should call Cat API WITHOUT API key" {
                Get-CatImage
                Assert-MockCalled OpenPage
            }
        }
    }

    Describe "Get-CatMeowMix" {
        Context "When call: CatMeowMix" {
            Mock OpenPage {} -Verifiable -ParameterFilter {
                "https://youtu.be/SbyZDq76T74"
            }

            It "Should open 'Cat Meow Mix' on Youtube" {
                Get-CatMeowMix
                Assert-MockCalled OpenPage
            }
        }
    }

    Describe "Get-CatMeow" {
        Context "When call: Get-CatMeow" {
            Mock PlayCatSound {} -Verifiable -ParameterFilter {
                "$ModuleRoot/cat-meow.wav"
            }

            It "Should play meow sound" {
                Get-CatMeow
                Assert-MockCalled PlayCatSound
            }
        }
    }

    Describe "Get-CatBabyMeow" {
        Context "When call: Get-CatBabyMeow" {
            Mock PlayCatSound {} -Verifiable -ParameterFilter {
                "$ModuleRoot/cat-baby-meow.wav"
            }

            It "Should play baby meow sound" {
                Get-CatBabyMeow
                Assert-MockCalled PlayCatSound
            }
        }
    }

    Describe "Get-CatFight" {
        Context "When call: Get-CatFight" {
            Mock PlayCatSound {} -Verifiable -ParameterFilter {
                "$ModuleRoot/cat-fight.wav"
            }

            It "Should play cat fight sound" {
                Get-CatFight
                Assert-MockCalled PlayCatSound
            }
        }
    }

    Describe "Get-CatAngry" {
        Context "When call: Get-CatAngry" {
            Mock PlayCatSound {} -Verifiable -ParameterFilter {
                "$ModuleRoot/cat-angry.wav"
            }

            It "Should play cat angry sound" {
                Get-CatAngry
                Assert-MockCalled PlayCatSound
            }
        }
    }

    Describe "Get-CatPurr" {
        Context "When call: Get-CatPurr" {
            Mock PlayCatSound {} -Verifiable -ParameterFilter {
                "$ModuleRoot/cat-angry.wav"
            }

            It "Should play cat purr sound" {
                Get-CatPurr
                Assert-MockCalled PlayCatSound
            }
        }
    }

    Describe "Get-CatYowl" {
        Context "When call: Get-CatYowl" {
            Mock PlayCatSound {} -Verifiable -ParameterFilter {
                "$ModuleRoot/cat-yowl.wav"
            }

            It "Should play cat yowl sound" {
                Get-CatYowl
                Assert-MockCalled PlayCatSound
            }
        }
    }
}