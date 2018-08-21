$SqlUsername = ""
$SqlPassword = ""
#$ConnectionString = "" # whatever you are testing

$ConnectionString = ""

$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $ConnectionString;
  
Write-Host "Testing connection string"
Start-Sleep -s 10      
$sqlConnection.Open();
        
$sqlConnection.Close();