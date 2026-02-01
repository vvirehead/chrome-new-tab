# updateimages.ps1
$ErrorActionPreference = "Stop"

$imagesDir = Join-Path $PSScriptRoot "images"
$outFile   = Join-Path $PSScriptRoot "images.json"

if (!(Test-Path $imagesDir)) { throw "Missing folder: $imagesDir" }

# Include common image formats supported by Chrome for CSS backgrounds
$exts = @("*.jpg","*.jpeg","*.png","*.webp","*.gif")

$files = foreach ($ext in $exts) {
  Get-ChildItem -Path $imagesDir -File -Filter $ext -ErrorAction SilentlyContinue
}

$names = $files | Sort-Object Name | Select-Object -ExpandProperty Name -Unique

if ($names.Count -eq 0) { throw "No images found in: $imagesDir" }

# Compact JSON, UTF-8
$names = @(
  $files | Sort-Object Name | Select-Object -ExpandProperty Name -Unique
)

if ($names.Count -eq 0) { throw "No images found in: $imagesDir" }

ConvertTo-Json -InputObject @($names) | Set-Content -Path $outFile -Encoding utf8

Write-Host "Wrote $($names.Count) entries to $outFile"
