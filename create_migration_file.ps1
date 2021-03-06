﻿# Allow to create a new migration file with the correct tag name for migration
# $version should be use to update a migration step
# prefix should be use to choise between R or V
Param(
    [string]$version,
    [string]$prefix
)

# Version
$sql_folder = "../sql_migration"
Write-host "version" $version.length.ToString()
Write-host "prefix" $prefix
if(!(Test-Path -Path $sql_folder )){
    New-Item -ItemType directory -Path $sql_folder
}
if ($version.length -eq 1) {
    New-Item -ErrorAction Ignore -ItemType directory -Path $sql_folder
    $fichiers = Get-ChildItem ../sql_migration/$prefix$version*.sql
    $elem = @()
    foreach ($i in $fichiers) {
        $elem += [int]$i.name.split('_')[1]
    }
    $elem = $elem | sort -descending
    if ($elem.length -gt 0) {
        $new_v = $elem[0] + 1
    } else {
        $new_v = 1
    }
} else {
    $fichiers = Get-ChildItem $sql_folder/v*.sql
    $elem = @()
    foreach ($i in $fichiers) {
        $elem = [int]$i.name.split('_')[0].split($prefix)[1]
    }
    $elem = $elem | sort -descending
    if ($elem.length -gt 0) {
        $new_v = $elem[0] +1
    } else {
        $new_v = 1
    }
}
# Description
$desc = Read-Host -Prompt "Description du nouveau fichier"
$desc = $desc.ToLower()
$fname = $desc
if ($desc.split(' ').length -gt 1) {
    $fname = ""
    $desc = $desc.split(' ')
    for ($i=0;$i -le  $desc.length;$i++) {
        if ($desc[$i].length -gt 0) {
            if ($fname.length -gt 0 -and $fname[$fname.length-1] -ne "_") {
                $fname +='_'
            }
            $fname += $desc[$i]
        }
    }
}
if ($version.length -eq 1) {
    $fname = $sql_folder + "/" + $prefix + $version + '_' + $new_v + "_" + $fname +'.sql'
} else {
    $fname = $sql_folder + "/" + $prefix + $new_v + '_1__' + $fname + '.sql'
}
Write-Host "Fichier créer : " + $fname
New-item  $fname
Write-Host "Fichier créer : " + $fname
