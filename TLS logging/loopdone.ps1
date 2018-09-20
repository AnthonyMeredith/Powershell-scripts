#$sitesFound = Get-IISSite Uncomment if you want to run this script against all IIS sites individually
$sitesFound = "*" # Comment out if you want to run against all sites individually 

$logValue = @('crypt-protocol', 'CRYPT_PROTOCOL', 'ServerVariable'),       # Multi-dimentional array 
             ('crypt-cipher', 'CRYPT_CIPHER_ALG_ID', 'ServerVariable'),
             ('crypt-hash', 'CRYPT_HASH_ALG_ID', 'ServerVariable'),
             ('crypt-keyexchange', 'CRYPT_KEYEXCHANGE_ALG_ID', 'ServerVariable')

foreach($site in $sitesFound)
{
    
    if($site -eq "")
    {
        Write-Host "`nERROR!! site variable is empty. `nPlease set it to * to apply at server level or enter the site you want to apply the logs to"

    }elseif($site -eq "*")
    {
        Write-Host "`nEnabling TLS logging at server level (all sites)`n"
        $config = "siteDefaults"

    }else
    {
        Write-Host "`nEnabling TLS logging on $site`n"
        $config = "site[@name='$($site)']"

    }

    Write-Host "`n"

    $properties = Get-WebConfigurationProperty -Filter "system.applicationHost/sites/$config/logFile/customFields"  -PSPath MACHINE/WEBROOT/APPHOST  -Name "."
    $filter = "system.applicationHost/sites/$config/logFile/customFields"

    foreach($log in $logValue){

        $found = 0
    
        foreach($prop in $properties.Collection){

            if($log[0] -eq $prop.logFieldName){

                $found = 1               
            }       
        }

        if($found -eq 1){
                
                Write-Host $log[0] "has been found"

            }else{

                $filter = "system.applicationHost/sites/$config/logFile/customFields"
                $psPath = 'MACHINE/WEBROOT/APPHOST'

                Write-Host $log[0] "has not been found"
                Write-Host "Adding log" $log[0]
                Add-WebConfigurationProperty -pspath $psPath  -filter $filter -name "." -value @{logFieldName=$log[0] ;sourceName=$log[1] ;sourceType=$log[2]}                
            }
    }
}