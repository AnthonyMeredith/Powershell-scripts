choco install -y sql2012.powershell


choco install -y sql-server-management-studio

sqlcmd -S ant-dev-sdb1.database.windows.net -d art-db -U dogadmin -P thisIsDog111 -i C:\Art.sql