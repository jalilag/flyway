Param(
    [string]$version
)
if ($version.length -gt 0) {
    $cmd = './create_migration_file.ps1 -prefix R -version ' + $version
} else {
    $cmd = './create_migration_file.ps1 -prefix R'
}
Invoke-Expression $cmd
