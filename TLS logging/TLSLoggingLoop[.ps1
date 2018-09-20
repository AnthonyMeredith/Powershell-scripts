$sitesFound = 'site1' #Get-IISSite

foreach($site in $sitesFound)
{
    Write-Host "`n"
    $site.name
    
    $property = Get-WebConfigurationProperty -Filter "system.applicationHost/sites/site[@name='$($site.name)']/logFile/customFields"  -PSPath MACHINE/WEBROOT/APPHOST  -Name "."
    $property.collection


    if(!$property.collection)
    {
        write-host "Enabling TLS logging on $site`n"
        $site = "site[@name='$($site)']"

        Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/$site/logFile/customFields" -name "." -value @{logFieldName='crypt-protocol';sourceName='CRYPT_PROTOCOL';sourceType='ServerVariable' }
        $sites
        Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/$site/logFile/customFields" -name "." -value @{logFieldName='crypt-cipher' ;sourceName='CRYPT_CIPHER_ALG_ID' ;sourceType='ServerVariable' }
        $sites
        Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/$site/logFile/customFields" -name "." -value @{logFieldName='crypt-hash' ;sourceName='CRYPT_HASH_ALG_ID' ;sourceType='ServerVariable' }
        $sites
        Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/$site/logFile/customFields" -name "." -value @{logFieldName='crypt-keyexchange' ;sourceName='CRYPT_KEYEXCHANGE_ALG_ID' ;sourceType='ServerVariable' }
        $sites
        write-host "Logging enabled on $site`n"
    
    }else
    {
    
        write-host "TLS logging already s on $site `n"

    }
}