Remove-Item C:\inetpub\wwwroot\* -Recurse -Force

Expand-Archive c:\Art.Web.zip -DestinationPath c:\

C:\Art.Web\Art.Web.deploy.cmd /y

Move-Item -Path C:\inetpub\wwwroot\Art.Web_deploy\* -Destination C:\inetpub\wwwroot

Remove-Item -path C:\inetpub\wwwroot\Art.Web_deploy -recurse 
Remove-Item -path C:\Art.Web -recurse 


start-sleep -s 20