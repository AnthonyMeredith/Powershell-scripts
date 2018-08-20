$SqlUsername = "svc-octopus"
$SqlPassword = "Password1234"
#$ConnectionString = "Data Source=(local);Initial Catalog=octopus-db;Persist Security Info=False;User ID=${SqlUsername};Password=${SqlPassword};Connection Timeout=300;" # whatever you are testing

$ConnectionString = "Server=tcp:ant-dev-sdb1.database.windows.net,1433;Initial Catalog=art-db;Persist Security Info=False;User ID=dogadmin;Password=thisIsDog111;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $ConnectionString;
  
Write-Host "Testing connection string"
Start-Sleep -s 10      
$sqlConnection.Open();
        
$sqlConnection.Close();