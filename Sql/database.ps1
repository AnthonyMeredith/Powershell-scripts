$SqlQuery = get-content "C:\Art.sql"

#$SqlQuery = "SELECT * from table;"

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = ""

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