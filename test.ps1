do
{
    $test = az vm list -g BuildserverRg -d --query "[?powerState=='VM stopped']"
	if($test -eq "[]")
	{
        Write-Host "VM is not stopped"
        Start-Sleep -s 60
	}
	else 
	{
        Write-Host "VM is stopped, creating image"  
        Start-Sleep -s 90
		./imageCreate.ps1 -recourceGroup $ResourceGroup -imageName $imageName -imgStoreRg $imgStoreRg  
	}
}while($test -eq "[]")