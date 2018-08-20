$SqlQuery = get-content "C:\Art.sql"

#$SqlQuery = "SELECT * from table;"

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server=tcp:ant-dev-sdb1.database.windows.net,1433;Initial Catalog=art-db;Persist Security Info=False;User ID=dogadmin;Password=thisIsDog111;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

$SqlConnection.Open()


$sqlcmd = $sqlConnection.CreateCommand()
$sqlcmd.Connection = $SqlConnection
$SqlCmd.CommandText = $SqlQuery


#$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
#$SqlCmd.CommandText = $SqlQuery
#$SqlCmd.Connection = $SqlConnection

$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter #$sqlcmd
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet) | Out-Null

$sqlcmd.Dispose()
$SqlConnection.Close()
$SqlConnection.Dispose()

Start-Sleep -s 20

$DataSet.Tables[0] | out-file "C:\Scripts\xxxx.csv"