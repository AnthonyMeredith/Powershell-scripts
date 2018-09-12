#this is for enabling tls on websites by amending the applicationHost.config file


$sitesFound = "site"

if ($sitesFound -eq "")
{

	$sites = "siteDefaults"

}else
{

	$sites = "site[@name='$($sitesFound)']"

}


Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/$sites/logFile/customFields" -name "." -value @{logFieldName='crypt-protocol';sourceName='CRYPT_PROTOCOL';sourceType='ServerVariable' }

Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/$sites/logFile/customFields" -name "." -value @{logFieldName='crypt-cipher' ;sourceName='CRYPT_CIPHER_ALG_ID' ;sourceType='ServerVariable' }

Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/$sites/logFile/customFields" -name "." -value @{logFieldName='crypt-hash' ;sourceName='CRYPT_HASH_ALG_ID' ;sourceType='ServerVariable' }

Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/$sites/logFile/customFields" -name "." -value @{logFieldName='crypt-keyexchange' ;sourceName='CRYPT_KEYEXCHANGE_ALG_ID' ;sourceType='ServerVariable' }


