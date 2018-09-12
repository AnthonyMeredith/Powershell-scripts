#this is for enabling tls on websites by amending the applicationHost.config file

#$findSites = Get-IISSite
#$sitesFound = $findSites.name
#$sitesFound

#foreach ($site in $sitesFound)
#{
Write-Host $site
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/siteDefaults[@name='$($sitesFound)']/logFile/customFields" -name "." -value @{logFieldName='crypt-protocol';sourceName='CRYPT_PROTOCOL';sourceType='ServerVariable' }
Write-Host $site
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/siteDefaults[@name='$($sitesFound)']/logFile/customFields" -name "." -value @{logFieldName='crypt-cipher' ;sourceName='CRYPT_CIPHER_ALG_ID' ;sourceType='ServerVariable' }
Write-Host $site
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/siteDefaults[@name='$($sitesFound)']/logFile/customFields" -name "." -value @{logFieldName='crypt-hash' ;sourceName='CRYPT_HASH_ALG_ID' ;sourceType='ServerVariable' }
Write-Host $site
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/sites/siteDefaults[@name='$($sitesFound)']/logFile/customFields" -name "." -value @{logFieldName='crypt-keyexchange' ;sourceName='CRYPT_KEYEXCHANGE_ALG_ID' ;sourceType='ServerVariable' }
Write-Host $site
#}

Start-Sleep -s 5

