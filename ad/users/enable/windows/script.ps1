$settings = Get-Content .\settings.json | ConvertFrom-Json
$settings

if ((Get-Module 'ActiveDirectory' -ListAvailable).Count -ge 1) {
    $splat = @{
        Identity = $settings.User
    }
    Enable-ADAccount @splat
} else {
    Write-Host 'ActiveDirectory module is not installed.'
}