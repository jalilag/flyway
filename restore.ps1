$cmd = 'flyway -configFiles="config/flyway.conf" clean;./migrate.ps1'
Invoke-Expression $cmd
