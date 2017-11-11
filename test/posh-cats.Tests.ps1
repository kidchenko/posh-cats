$ModuleManifestName = 'posh-cats.psd1'
$ModuleManifestPath = "$PSSCriptRoot/..\$ModuleManifestName"

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath | Should Not BeNullOrEmpty
        $? | Should Be $true
    }
}

Describe 'Juca' {
    It 'Juca' {
        #$catNames = LoadCatNames
        #$catNames.Count | Should Be (100)
    }

    It 'Get-CatName should return a name' {
        # $allNames = Get-Content -Raw -Path "$PSSCriptRoot/..\cat-names.json" | ConvertFrom-Json

        # $name = Get-CatName

        # $allNames | Should BeLike "*$name*"
    }

}
