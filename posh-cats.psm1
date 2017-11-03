# Implement your module commands in this script.


# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.

function LoadCatNames {
    Get-Content -Raw -Path "$PSScriptRoot\cat-names.json" | ConvertFrom-Json
}

<#

.SYNOPSIS

Get name of cats

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

function Convert-UnicodeToString {
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

function Get-CatEmoji {
    Convert-UnicodeToString "U+1F63A"
}

Export-ModuleMember -Function *-*
