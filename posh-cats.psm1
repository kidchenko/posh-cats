# Implement your module commands in this script.


# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.

function LoadCatNames {
    Get-Content -Raw -Path "$PSScriptRoot\cat-names.json" | ConvertFrom-Json
}

function Get-CatName {
    LoadCatNames | Get-Random
}

Export-ModuleMember -Function *-*
