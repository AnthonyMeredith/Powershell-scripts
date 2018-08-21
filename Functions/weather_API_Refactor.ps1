

function Get-weather {

    $userInput = Read-Host "Would you like the current weather please enter [1] for a chosen day enter [2] or chosen day and time enter [3]"

    # If function to check users input choice
    if($userInput -eq 1){

        Get-CurrentWeather # Calling Get-CurrentWeather function
      
    }
    elseif($userInput -eq 2) {

        Get-WeatherDay # Calling Get-WeatherDay function 

    }
    elseif($userInput -eq 3) {

        Get-HourlyWeather # Calling Get-HourlyWeather
    }

}

# Function to convert epoch date to human readable format passing $epochDate variable
Function Get-DateFromEpoch ($epochDate) {

   [timezone]::CurrentTimeZone.ToLocalTime([datetime]'1/1/1970').AddSeconds($EpochDate)

}

function Get-CurrentWeather {

    $inputDate = Get-Date # Getting current date from the computer
    $ConvertedTime = [Math]::Floor([decimal](Get-Date($inputDate).ToUniversalTime()-uformat "%s")) # [Math] is a static class [Math]::Floor the :: allows us to access a static method or field of a class so in this case we are accessing the floor method to rounds a number to the nearest whole number, Get-Date(Get-Date).ToUniversalTime()-uformat "%s") function is 

    # API request
    $request = "https://api.darksky.net/forecast/1f76693d9f8a17cd11aab3871527b2fe/51.481581,-3.1790,$convertedTime"+"?units=auto" # Placing the Dark Sky URL into a variable to make the request instead of re-writing the whole URL 
    $summary = Invoke-RestMethod $request # Making the request to the Dark Sky API and placing it into the $summary variable
    $darkSkyResult = ConvertTo-Json -Depth 3 $summary # -Depth parameter formats the json file at each indentation so -Depth 3 will only show the firt set of indented information
    Set-Content Current_Weather.json $darkSkyResult # Creating a new file and setting the content to the data held in the $darkSkyResult variable  

    $extractedData = $summary.currently | select time, summary, icon, temperature, precipProbability, windSpeed, cloudCover # Extracting the time, summary, icon, temperature, precipProbability, windSpeed, cloudCover sections of the currently section

    $result = @{ Current_Weather_Forcast = $extractedData} # Creating a dictionary and making the data extracted from the API request the value of the Current_Weather_Forcast key @{   } is how to create dictionaries in powershell

    $fileOutput = ConvertTo-Json -Depth 3 $result # Creating a new file and setting the content to the data held in the $fileOutput variable
    Set-Content Current_Weather_Output.json $fileOutput # Creating a new file and setting the content to the data held in the $fileOutput variable 

    # Variable to hold the data from the users chosen json file and converting it to a .net object
    $parseText = get-content Current_Weather_Output.json | ConvertFrom-Json 

    # foreach loop to go through the collections in the Hourly_Weather_Forcast section of the file storing each line in the $line variable
    foreach ($line in $parseText.Current_Weather_Forcast) # foreach loop to go through each line in the file storing each line in the $line variable
    {
        $line.time = (Get-DateFromEpoch($line.time)).ToString("dd/MM/yyyy HH:mm") # Making the time nested time object equal to the converted human readable date
    } 

    $parseText | ConvertTo-Json | Set-Content Current_Weather_Output.json

    #(get-content c:\1.txt) | foreach-object {$_ -replace "prod", "qa1"} | set-content c:\1.txt # One liner for above foreach loop
}

function Get-WeatherDay {

    
    $userDate = Read-Host "Please enter the date you want the weather for in DD/MM/YYYY format"

    $inputDate = Get-Date -Date $userDate # Converting user input time to a datetime the function can use

    $ConvertedTime = [Math]::Floor([decimal](Get-Date($inputDate).ToUniversalTime()-uformat "%s")) # [Math] is a static class [Math]::Floor the :: allows us to access a static method or field of a class so in this case we are accessing the floor method to rounds a number to the nearest whole number, Get-Date(Get-Date).ToUniversalTime()-uformat "%s") function is 
    
    $request = "https://api.darksky.net/forecast/1f76693d9f8a17cd11aab3871527b2fe/51.481581,-3.1790,$convertedTime"+"?units=auto" # Placing the Dark Sky URL into a variable to make the request instead of re-writing the whole URL 
    $summary = Invoke-RestMethod $request # Making the request to the Dark Sky API and placing it into the $summary variable
    $darkSkyResult = ConvertTo-Json -Depth 3 $summary # converting the API request to json for the output to file
    Set-Content Daily_Weather.json $darkSkyResult # Creating a new file and setting the content to the data held in the $darkSkyResult variable  

    $extractedData = $summary.daily.data | select time, summary, icon, temperatureHigh, temperatureLow, precipProbability, cloudCover, windSpeed # Extracting the time, summary, icon, temperatureHigh, temperatureLow, precipProbability, windSpeed, cloudCover sections of the currently section

    $result = @{ Daily_Weather_Forcast = $extractedData} # Creating a dictionary and making the data extracted from the API request the value of the Current_Weather_Forcast key @{   } is how to create dictionaries in powershell

    $fileOutput = ConvertTo-Json -Depth 3 $result # Creating a new file and setting the content to the data held in the $fileOutput variable  
    Set-Content Daily_Weather_Output.json $fileOutput # Creating a new file and setting the content to the data held in the $fileOutput variable 

    # Variable to hold the data from the users chosen json file and converting it to a .net object
    $parseText = get-content Daily_Weather_Output.json | ConvertFrom-Json

    # foreach loop to go through the collections in the Hourly_Weather_Forcast section of the file storing each line in the $line variable
    foreach ($line in $parseText.Daily_Weather_Forcast) # foreach loop to go through each line in the file storing each line in the $line variable
    {
        $line.time = (Get-DateFromEpoch($line.time)).ToString("dd/MM/yyyy") # Making the time nested time object equal to the converted human readable date
    } 

    $parseText | ConvertTo-Json | Set-Content Daily_Weather_Output.json

}

function Get-HourlyWeather{

    $userDate = Read-Host "Please enter the date you want the weather for in DD/MM/YYYY format"
    $userHour = Read-Host "Please enter the hour of the day you would like the weather from 00 - 23"
    $inputDate = Get-Date -Date $userDate -Hour $userHour

    $ConvertedTime = [Math]::Floor([decimal](Get-Date($inputDate).ToUniversalTime()-uformat "%s")) # [Math] is a static class [Math]::Floor the :: allows us to access a static method or field of a class so in this case we are accessing the floor method to rounds a number to the nearest whole number, Get-Date(Get-Date).ToUniversalTime()-uformat "%s") function is 
    
    # API request
    $request = "https://api.darksky.net/forecast/1f76693d9f8a17cd11aab3871527b2fe/51.481581,-3.1790,$convertedTime"+"?units=auto" # Placing the Dark Sky URL into a variable to make the request instead of re-writing the whole URL 
    $summary = Invoke-RestMethod $request # Making the request to the Dark Sky API and placing it into the $summary variable
    $darkSkyResult = ConvertTo-Json -Depth 3 $summary # -Depth parameter formats the json file at each indentation so -Depth 3 will only show the firt set of indented information
    Set-Content Hourly_Weather.json $darkSkyResult # Creating a new file and setting the content to the data held in the $darkSkyResult variable  

    # Extracting the selected data from the ARI request
    #$inputText = $darkSkyResult | ConvertFrom-Json
    $extractedData = $summary.hourly.data | select time, summary, icon, temperature, precipProbability, windSpeed, cloudCover # Extracting the time, summary, icon, temperature, precipProbability, windSpeed, cloudCover sections of the currently section


    $result = @{ Hourly_Weather_Forcast = $extractedData} # Creating a dictionary and making the data extracted from the API request the value of the Current_Weather_Forcast key @{   } is how to create dictionaries in powershell

    $fileOutput = ConvertTo-Json -Depth 3 $result # Creating a new file and setting the content to the data held in the $fileOutput variable
    Set-Content Hourly_Weather_Output.json $fileOutput # Creating a new file and setting the content to the data held in the $fileOutput variable 

    # Variable to hold the data from the users chosen json file and converting it to a .net object
    $parseText = get-content Hourly_Weather_Output.json | ConvertFrom-Json 
               
    $convertedArray = [System.Collections.ArrayList]::new()

    # foreach loop to go through the collections in the Hourly_Weather_Forcast section of the file storing each line in the $line variable
    foreach ($line in $parseText.Hourly_Weather_Forcast) 
    {
        if($line.time -ge $convertedTime)
        {
            $line.time = (Get-DateFromEpoch($line.time)).ToString("dd/MM/yyyy HH:mm") # Making the time nested time object equal to the converted human readable date
             
            $convertedArray.add($line)
        }

    } 


    $parseText = @{ Hourly_Weather_Forcast = $convertedArray}
    
    $parseText | ConvertTo-Json | Set-Content Hourly_Weather_Output.Json
 
}

Get-Weather

        #if ($extractedTimestamp)
        #{   
            #$extractedTimestamp
            #$line.Hourly_Weather_Forcast.time
            #$line
            #$fileOutput = ConvertTo-Json -Depth 3 $line
            #$fileOutput
            #Set-Content Line.json $fileOutput 
            #$line
            #$extractedDate = $line -split ' '

            #$extractedDate[2]
            #$extractedDate = $parseText.Current_Weather_Forcast.time
            #$humanDate = Get-DateFromEpoch($extractedTimestamp[1])
            #$humanDate
            #$parseText -replace "\d{4,}","$humanDate" | set-content Hourly_Weather_Output.json

            <#$titleSummary = "Hourly Summary "

            $titleSummary | Out-File Hourly.txt
    
            $request = "https://api.darksky.net/forecast/1f76693d9f8a17cd11aab3871527b2fe/51.481581,-3.1790,$convertedTime"+"?units=auto" 
            $summary = Invoke-RestMethod $request | # Making the request to the Dark Sky API
            ConvertTo-Json -Depth 3 |# -Depth parameter formats the json file at each indentation so -Depth 1 will only show the firt set of indented information
            Out-File Hourly.json

            $inputFromJson = Get-Content Hourly.json |
            convertFrom-json | # Converting content from json
            select -expand hourly | # Expanding the hourly section from the file
            select -expand data | # Expanding the data section from the file 
            select  time, summary, temperature, precipProbability, cloudCover, windSpeed | # Extracting the summary, time, icon, temperature, precipProbability, cloudCover, windSpeed sections of the currently section
            Out-File Hourly.txt -Append # appending data to existing file

            $timeChange = Get-Content Hourly.json | # Getting content from from the json file
            convertFrom-json | # Converting content from json    
            select -expand daily | # Expanding the daily section from the file
            select -expand data | # Expanding the data section from the file
            select  time # Selecting the time field for time conversion#>

            #$time = $summary.time # Accessing time as a part of the $summary variable
            #$time

            #$extractedTimestamp = $line.Hourly_Weather_Forcast.time
            #$extractedTimestamp
            #$humanDate = Get-DateFromEpoch($extractedTimestamp[1])

            #$parseText -replace $line.Hourly_Weather_Forcast.time,"$humanDate" | set-content Hourly_Weather_Output.json
            # If statement to check if the word is present in the current line stored in the $line variable
            <#foreach ($ele in $line.time){
                if ($ele)
                { 
                    $ele
               
                    $ele = $humanDate 
                    #$parseText -replace $parseText.Hourly_Weather_Forcast.time,"$humanDate" | set-content Hourly_Weather_Output.json
                }
            }#>

                        #$a = @($line.time) #
            #$line.time
            #$parseText | Where-Object { (-not($line -match '\d{4,}')) }

            #$line | ConvertTo-Json | Out-file -Append Hourly_Weather_Output.json
            #$parseText | Where-Object {$_ -match $a} | ConvertTo-Json | Set-Content out.txt

            #$parseText -replace "\d{4,}","$humanDate" | Set-Content Hourly_Weather_Output.json

            #param([string]$apiKey

            #)

            #$apikey = Read-Host "Please enter Dark Sky API key" 