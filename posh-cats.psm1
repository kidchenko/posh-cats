<#

.SYNOPSIS
    Get random name of cats.

.DESCRIPTION
    This function allows you to get a single or a list of name of cats.

.PARAMETER All
    Show all cat names.

.EXAMPLE
    Get-CatName

    This command get a single cat name. e.g Gracie

.EXAMPLE
    Get-CatName -All

    This command get all cat names.

#>
[CmdletBinding]
function Get-CatName {
    Param(
        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [switch]$All
    )

    $allCats = LoadCatNames

    if ($All -eq $true)
    {
        return $allCats
    }
    $allCats | Get-Random
}

<#

.SYNOPSIS
    Get a cat face emoji.

.DESCRIPTION
    This function write a cat face emoji in the console using the Emoji Unicode Symbol. Your shell need suport Unicode.

.EXAMPLE
    Get-CatEmoji

    This command return a cat emoji face. 🐱

#>
[CmdletBinding]
function Get-CatEmoji {
    ConvertUnicodeToString "U+1F431"
}


<#

.SYNOPSIS
    Open the "100 Most Important Cat Pictures Of All Time" page on BuzzFeed.

.DESCRIPTION
    Open BuzzFeed in the cutiest page about cats. OK, this is it. This is the one. We can all finally shut down the internet and go home after this.

.EXAMPLE
    Get-CatBuzz

    This command open BuzzFeed in your browser.

#>
[CmdletBinding]
function Get-CatBuzz {
    OpenPage "https://www.buzzfeed.com/expresident/best-cat-pictures"
}


<#

.SYNOPSIS
    Get a random image of cats.

.DESCRIPTION
    Open a cat image in your browser.

.EXAMPLE
    Get-CatImage

    This command open a cat image in your browser.

#>
[CmdletBinding]
function Get-CatImage {
    $targetUrl = if ($IsWindows -eq $true)
    {
        "https://thecatapi.com/api/images/get?api_key=MjQyMzQ3"
    }
    else
    {
        "http://thecatapi.com/api/images/get"
    }

    OpenPage $targetUrl
}

<#

.SYNOPSIS
    Open a MeowMix video in youtube.

.DESCRIPTION
    Open a 10h MeowMix video in youtube.

.EXAMPLE
    Get-CatMeowMix

    This command open MeowMix in youtube.

#>
[CmdletBinding]
function Get-CatMeowMix {
    OpenPage "https://youtu.be/SbyZDq76T74"
}


<#

.SYNOPSIS
    Play a meow sound effect.

.DESCRIPTION
    Pay a wav sound of cat meowing.

.EXAMPLE
    Get-CatMeow

    This command play a meow effect.

#>
[CmdletBinding]
function Get-CatMeow {
    PlayCatSound "$PSSCriptRoot/cat-meow.wav"
}

<#

.SYNOPSIS
    Play a baby cat meow sound effect.

.DESCRIPTION
    Pay a wav sound of baby cat meowing.

.EXAMPLE
    Get-CatBabyMeow

    This command play a baby cat meow effect.

#>
[CmdletBinding]
function Get-CatBabyMeow {
    PlayCatSound "$PSSCriptRoot/cat-baby-meow.wav"
}

<#

.SYNOPSIS
    Play a sound effect of cats fighting.

.DESCRIPTION
    Pay a wav sound of cats fighting.

.EXAMPLE
    Get-CatFight

    This command play cats fighting.

#>
[CmdletBinding]
function Get-CatFight {
    PlayCatSound "$PSSCriptRoot/cat-fight.wav"
}


<#

.SYNOPSIS
    Play a sound effect of a cat angry.

.DESCRIPTION
    Pay a wav sound of an angry cat.

.EXAMPLE
    Get-CatAngry

    This command play a angry cat.

#>
[CmdletBinding]
function Get-CatAngry {
    PlayCatSound "$PSScriptRoot/cat-angry.wav"
}


<#

.SYNOPSIS
    Play a purr sound effect.

.DESCRIPTION
    Play a purr... purr... purr sound effect (purr is the sound when the cat want some affection).

.EXAMPLE
    Get-CatPurr

    This command play a purr cat effect.

#>
function Get-CatPurr {
    PlayCatSound "$PSSCriptRoot/cat-purr.wav"
}


<#

.SYNOPSIS
    Play a yowl (when the cat is angry) sound effect.

.DESCRIPTION
    Play a yowl sound effect. This effect is very common in adult cats.

.EXAMPLE
    Get-CatYowl

    This command play a yowl cat effect.

#>
[CmdletBinding]
function Get-CatYowl {
    PlayCatSound "$PSSCriptRoot/cat-yowl.wav"
}

function ConvertUnicodeToString {
    param (
        [Parameter(Mandatory = $true)]
        [string]$unicodeChars
    )

    $unicodeChars = $unicodeChars -replace 'U\+', '';

    $unicodeArray = @();
    foreach ($unicodeChar in $unicodeChars.Split(' ')) {
        $intRepresentation = [System.Convert]::ToInt32($unicodeChar, 16);
        $unicodeArray += [System.Char]::ConvertFromUtf32($intRepresentation);
    }

    $unicodeArray -join [String]::Empty;
}

function LoadCatNames {
    Get-Content -Raw -Path "$PSSCriptRoot/cat-names.json" | ConvertFrom-Json
}

function PlayCatSound ($file) {
    if ($IsWindows -eq $true)
    {
        $player = New-Object System.Media.SoundPlayer
        $player.SoundLocation = Get-Item $file
        $player.Play()
    }
    else
    {
        open $file --hide --background
    }
}

function OpenPage ($url) {
    if ($IsWindows -eq $true)
    {
        Start-Process -FilePath $url
    }
    else
    {
        open "$url" --args "$url"
    }
}

# Before PowerShell Core, the variable $IsWindows do not exist
$IsWindows = $IsWindows -or $PSVersionTable.PSEdition -eq "Desktop"

# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.

New-Alias -Name Get-Meow -Value Get-CatMeow

Export-ModuleMember -Function *-* -Alias *