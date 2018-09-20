$site = 'site1'
<#$logs = @(
         ('logFieldName', 'sourceName', 'sourceType'), 
         ('crypt-protocol', 'CRYPT_PROTOCOL', 'ServerVariable')
    )
#$property = ""
#Start-Sleep -s 5
$logs[0][0]
$logs[1][2]#>

    if($site -eq "")
    {
        Write-Host "`nERROR!! site variable is empty. `nPlease set it to * to apply at server level or enter the site you want to apply the logs to"
        $test = 1

    }elseif($site -eq "*")
    {
        Write-Host "`nEnabling TLS logging at server level`n"
        $sites = "siteDefaults"
        $name = "at server level (all sites)"

    }else
    {
        Write-Host "`nEnabling TLS logging on $site`n"
        $sites = "site[@name='$($site)']"
        $name = " on $site"

    }

    Write-Host "`n"

    if($test -ne 1)
    {
        $property = Get-WebConfigurationProperty -Filter "system.applicationHost/sites/$sites/logFile/customFields"  -PSPath MACHINE/WEBROOT/APPHOST  -Name "."
        Write-Host $property.Collection
        
        if(!$property.Collection)
        {    
            $filter = "system.applicationHost/sites/$sites/logFile/customFields"
            $psPath = 'MACHINE/WEBROOT/APPHOST'

            Add-WebConfigurationProperty -pspath $psPath  -filter $filter -name "." -value @{logFieldName='crypt-protocol';sourceName='CRYPT_PROTOCOL';sourceType='ServerVariable' }

            Add-WebConfigurationProperty -pspath $psPath  -filter $filter -name "." -value @{logFieldName='crypt-cipher' ;sourceName='CRYPT_CIPHER_ALG_ID' ;sourceType='ServerVariable' }

            Add-WebConfigurationProperty -pspath $psPath  -filter $filter -name "." -value @{logFieldName='crypt-hash' ;sourceName='CRYPT_HASH_ALG_ID' ;sourceType='ServerVariable' }

            Add-WebConfigurationProperty -pspath $psPath  -filter $filter -name "." -value @{logFieldName='crypt-keyexchange' ;sourceName='CRYPT_KEYEXCHANGE_ALG_ID' ;sourceType='ServerVariable' }
        Start-Sleep -s 5
        }else
        {
            Write-Host "`nTLS logging enabled $name"
        }

    }else
    {
        Write-Host "Site variable is empty"
    }

