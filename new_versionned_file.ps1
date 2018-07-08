Param(
    [string]$version
)
Write-Output $version.length
if ($version.length -gt 0) {
    $cmd = './create_migration_file.ps1 -prefix V -version ' + $version
} else {
    $cmd = './create_migration_file.ps1 -prefix V'
}
Invoke-Expression $cmd
