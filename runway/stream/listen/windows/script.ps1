$settings = Get-Content .\settings.json | ConvertFrom-Json
$settings

if ($settings.'Output Type'.ToLower() -match 'tcp|pipe|file') {
    $rw = '..\..\..\runway.exe'
    $commandString = "-N -S $($settings.host) stream --listen $($settings.'Stream Name') --output $($settings.'Output Type')://$($settings.Address) --persistent"
    if ($settings.TimeOut) {
        $commandString += " --timeout $($settings.TimeOut)"
    }
    Write-Host "$rw $commandString"
    Invoke-Command -ScriptBlock ([scriptblock]::Create("$rw $commandString")) *> .\results\stdout.txt
}