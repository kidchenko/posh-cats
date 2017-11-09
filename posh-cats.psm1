# Implement your module commands in this script.


# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.

<#

.SYNOPSIS
    Get random name of cats.

.DESCRIPTION
    This function allows you to get a single or a list of name of cats.

.PARAMETER Filter
    Filter the cat name, accept wildcards e.g *a | *a* | *a

.PARAMETER All
    Show all cat names.

.EXAMPLE
    Get-CatName

    This command get a single cat name. e.g Gracie

.EXAMPLE
    Get-CatName -Filter a*

    This command get a single cat name filtering the names that start with a. e.g Angel

.EXAMPLE
    Get-CatName -All

    This command get all cat names.

#>
[CmdletBinding]
function Get-CatName {
    Param(
        [string]$Filter = "*",
        [switch]$All
    )

    $allCats = LoadCatNames

    if ($All -eq $true) {
        return $allCats
    }

    $allCats | Where-Object { $_ -like $Filter } | Get-Random
}

<#

.SYNOPSIS
    Get a cat face emoji.

.DESCRIPTION
    This function write a cat face emoji in the console using the Emoji Unicode Symbol. Your shell need suport Unicode.

.EXAMPLE
    Get-CatEmoji

    This command get a cat emoji face. 🐱
#>
[CmdletBinding]
function Get-CatEmoji {
    ConvertUnicodeToString -UnicodeChars "U+1F431"
}

function Get-CatBuzz {
    Start-Process -FilePath "https://www.buzzfeed.com/expresident/best-cat-pictures"
}

<#
.SYNOPSIS
Get a cat image

.DESCRIPTION
Get a cat image and open in the browser.

.EXAMPLE
Get-CatImage

#>
[CmdletBinding]
function Get-CatImage {
    Start-Process -FilePath "http://thecatapi.com/api/images/get?api_key=MjQyMzQ3"
}

function Get-CatMeowYoutubeMix {
    Start-Process -FilePath "https://youtu.be/SbyZDq76T74"
}


function Get-CatMeow {
    PlayCatSound "$PSScriptRoot\cat-meow.wav"
}

function Get-CatBabyMeow {
    PlayCatSound "$PSScriptRoot\cat-baby-meow.wav"
}

function Get-CatFight {
    PlayCatSound "$PSScriptRoot\cat-fight.wav"
}

function Get-CatAngry {
    PlayCatSound "$PSScriptRoot\cat-angry.wav"
}

function Get-CatPurr {
    PlayCatSound "$PSScriptRoot\cat-purr.wav"
}

function Get-CatYowl {
    PlayCatSound "$PSScriptRoot\cat-yowl.wav"
}

function ConvertUnicodeToString {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $UnicodeChars
    )

    $UnicodeChars = $UnicodeChars -replace 'U\+', '';

    $UnicodeArray = @();
    foreach ($UnicodeChar in $UnicodeChars.Split(' ')) {
        $Int = [System.Convert]::ToInt32($UnicodeChar, 16);
        $UnicodeArray += [System.Char]::ConvertFromUtf32($Int);
    }

    $UnicodeArray -join [String]::Empty;
}

function LoadCatNames {
    Get-Content -Raw -Path "$PSScriptRoot\cat-names.json" | ConvertFrom-Json
}

function PlayCatSound ($file) {
    $player = New-Object System.Media.SoundPlayer
    $player.SoundLocation = Get-Item $file
    $player.Play()
}

Export-ModuleMember -Function *-*