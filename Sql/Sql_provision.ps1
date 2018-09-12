choco install -y sql2012.powershell


choco install -y sql-server-management-studio

sqlcmd -S ant-dev-sdb1.database.windows.net -d art-db -U techtest -P Password1234 -i C:\Art.sql