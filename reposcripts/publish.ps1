param (
    [switch]$Test,
    [string]$Server = 'portal.brazencloud.com',
    [string]$BasePublishPath = './',
    [string]$UtilityPath = './runway.bin',
    [switch]$Public,
    [string]$NameSpacePrefix
)

$baseDir = Get-Item $PSScriptRoot/../
foreach ($manifest in (Get-ChildItem $BasePublishPath -Filter manifest.txt -Recurse)) {
    
    # Determine namespace based on folder structure
    if ($NameSpacePrefix.Length -gt 0) {
        $namespace = $NameSpacePrefix + ':' + $manifest.Directory.Name
    } else {
        $rPath = $manifest.FullName.Replace($baseDir.FullName, '').Trim('\/')
        $namespace = ($rPath -split '\\|\/' | Select-Object -SkipLast 1) -join ':'
    }
    Write-Host "----------------------------------------------"
    Write-Host "Found: '$rPath', publishing as '$namespace'..."
    
    # Publish the Action
    if ($Test.IsPresent) {
        if ($Public.IsPresent) {
            & $UtilityPath -q -N -S $Server build -i $($manifest.FullName) -o "$($namespace.Replace(':','-')).apt" --PUBLIC
        } else {
            & $UtilityPath -q -N -S $Server build -i $($manifest.FullName) -o "$($namespace.Replace(':','-')).apt"
        }
    } else {
        if ($Public.IsPresent) {
            & $UtilityPath -q -N -S $Server build -i $($manifest.FullName) -o "$($namespace.Replace(':','-')).apt" -p $($namespace.ToLower()) --PUBLIC
        } else {
            & $UtilityPath -q -N -S $Server build -i $($manifest.FullName) -o "$($namespace.Replace(':','-')).apt" -p $($namespace.ToLower())
        }
    }
}