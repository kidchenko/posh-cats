# Implement your module commands in this script.


# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.



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

[CmdletBinding]
function Get-CatEmoji {
    ConvertUnicodeToString "U+1F63A"
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

Export-ModuleMember -Function *-*