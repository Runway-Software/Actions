$settings = Get-Content .\settings.json | ConvertFrom-Json

if ((Get-Module 'ActiveDirectory' -ListAvailable).Count -ge 1) {
    $splat = @{
        Filter = $settings.Filter
    }
    $out = Get-AdDomainController @splat
    if ($settings.'Only JSON'.ToString() -ne 'true') {
        $out
    }
    $out | ConvertTo-Json -Depth 1
    if ($settings.'CSV Out'.ToString() -eq 'true') {
        $out | Export-Csv .\results\DCs.csv -NoTypeInformation
    } else {
        $out | ConvertTo-Json -Depth 1 | Out-File .\results\DCs.json
    }
} else {
    Write-Host 'ActiveDirectory module is not installed.'
}