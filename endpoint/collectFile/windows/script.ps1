$settings = Get-Content .\settings.json | ConvertFrom-Json
$settings

if (Test-Path $settings.'File Path') {
    Copy-Item $settings.'File Path' -Destination .\results
} else {
    Write-Host "'$($settings.'File Path')' is not a valid path."
}