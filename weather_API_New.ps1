

function Get-weather {

    param([string]$apiKey

    )

    #$apikey = Read-Host "Please enter Dark Sky API key" 
    
    #Google API key AIzaSyAcRiFIvprj6A-Z8rUlZWG9RdpzxVHZ2Io


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

Function Get-DateFromEpoch ($epochDate) {

   [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($EpochDate))

}

function Get-CurrentWeather {

    $inputDate = Get-Date # Getting current date from the computer
    $ConvertedTime = [Math]::Floor([decimal](Get-Date($inputDate).ToUniversalTime()-uformat "%s")) # [Math] is a static class [Math]::Floor the :: allows us to access a static method or field of a class so in this case we are accessing the floor method to rounds a number to the nearest whole number, Get-Date(Get-Date).ToUniversalTime()-uformat "%s") function is 

    $titleSummary = "Current Summary"
    $titleSummary | Out-File Current_Weather.txt

    $request = "https://api.darksky.net/forecast/1f76693d9f8a17cd11aab3871527b2fe/51.481581,-3.1790,$convertedTime"+"?units=auto" 
    $summary = Invoke-RestMethod $request | # Making the request to the Dark Sky API
    ConvertTo-Json -Depth 3 | # -Depth parameter formats the json file at each indentation so -Depth 1 will only show the firt set of indented information
    Out-file Current_Weather.json

    $inputFromJson = Get-Content Current_Weather.json | # Getting content from from the json file
    convertFrom-json | # Converting content from json    
    select -expand currently | # Expanding the currently section from the file
    select  time, summary, icon, temperature, precipProbability, cloudCover, windSpeed # Extracting the summary, time, icon, temperature, precipProbability, cloudCover, windSpeed sections of the currently section
    
    $inputFromJson | Out-File Current_Weather.txt -Append # appending data to existing file
    $humanDate = [System.DateTimeOffset]::FromUnixTimeSeconds($inputFromJson.time).datetime.tolocaltime() # Accessing the FromUnixTimeSeconds static method from the System.DateTimeOffset class
    $parseText = get-content Current_Weather.txt # Variable to hold the text from the users chosen file

    foreach ($line in $parseText) # foreach loop to go through each line in the file storing each line in the $line variable
    {
        # If statement to check if the regex string is present in the current line stored in the $line variable
        if ($line -match "\d{4,}")
        {          
            $parseText -replace "\d{4,}","$humanDate" | set-content Current_Weather.txt # replacing the found regex string, in this case epoch time to a human readable time format
        }
    } 

    #(get-content c:\1.txt) | foreach-object {$_ -replace "prod", "qa1"} | set-content c:\1.txt # One liner for above foreach loop
}

function Get-WeatherDay {

    
    $userDate = Read-Host "Please enter the date you want the weather for in DD/MM/YYYY format"
    #$userHour = Read-Host "Please enter the hour of the day you would like the weather from 00 - 23"
    $inputDate = Get-Date -Date $userDate #-Hour $userHour # Converting user input time to a datetime the function can use
    #$inputDate
    $ConvertedTime = [Math]::Floor([decimal](Get-Date($inputDate).ToUniversalTime()-uformat "%s")) # [Math] is a static class [Math]::Floor the :: allows us to access a static method or field of a class so in this case we are accessing the floor method to rounds a number to the nearest whole number, Get-Date(Get-Date).ToUniversalTime()-uformat "%s") function is 
    $convertedTime
    
    $titleSummary = "Weather Summary"
    $titleSummary | Out-File Daily.txt

    $request = "https://api.darksky.net/forecast/1f76693d9f8a17cd11aab3871527b2fe/51.481581,-3.1790,$convertedTime"+"?units=auto" 
    $summary = Invoke-RestMethod $request | # Making the request to the Dark Sky API
    ConvertTo-Json -Depth 3 | # -Depth parameter formats the json file at each indentation so -Depth 1 will only show the firt set of indented information
    Out-file Daily.json

    $inputFromJson = Get-Content Daily.json | # Getting content from from the json file
    convertFrom-json | # Converting content from json    
    select -expand daily | # Expanding the daily section from the file
    select -expand data | # Expanding the data section from the file
    select  time, summary, icon, temperatureHigh, temperatureLow, precipProbability, cloudCover, windSpeed | # Selecting the summary, time, icon, temperatureHigh, temperatureLow, precipProbability, cloudCover, windSpeed sections of the currently section for extraction
    ConvertTo-Json |
    Out-File Daily.txt -Append # appending data to existing file

    
    $timeChange = Get-Content Daily.json | # Getting content from from the json file
    convertFrom-json | # Converting content from json    
    select -expand daily | # Expanding the daily section from the file
    select -expand data | # Expanding the data section from the file
    select  time # Selecting the time field for time conversion

    #$epochDate = Get-DateFromEpoch($timeChange.time)
    $parseText = get-content Daily.txt # Variable to hold the text from the users chosen file

    foreach ($line in $parseText) # foreach loop to go through each line in the file storing each line in the $line variable
    {
        # If statement to check if the regex string is present in the current line stored in the $line variable
        if ($line -match "\d{4,}")
        {        
            $humanDate = Get-DateFromEpoch($timeChange.time)  
            $parseText -replace "\d{4,}","$humanDate" | set-content Daily.txt # replacing the found regex string, in this case epoch time to a human readable time format
        }
    }
}

function Get-HourlyWeather{

    $userDate = Read-Host "Please enter the date you want the weather for in DD/MM/YYYY format"
    #$userHour = Read-Host "Please enter the hour of the day you would like the weather from 00 - 23"
    $inputDate = Get-Date -Date $userDate #-Hour $userHour

    $ConvertedTime = [Math]::Floor([decimal](Get-Date($inputDate).ToUniversalTime()-uformat "%s")) # [Math] is a static class [Math]::Floor the :: allows us to access a static method or field of a class so in this case we are accessing the floor method to rounds a number to the nearest whole number, Get-Date(Get-Date).ToUniversalTime()-uformat "%s") function is 
    
    $titleSummary = "Hourly Summary "
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
    select  time # Selecting the time field for time conversion

    #$epochDate = Get-DateFromEpoch($timeChange.time)

    $parseText = get-content Hourly.txt # Variable to hold the text from the users chosen file

    foreach ($line in $parseText) # foreach loop to go through each line in the file storing each line in the $line variable
    {
        
        # If statement to check if the word is present in the current line stored in the $line variable
        if ($line -match "\d{4,}")
        {    
            $humanDate = Get-DateFromEpoch($timeChange.time)
            $parseText -replace "\d{4,}","$humanDate" | set-content Hourly.txt
        }
    } 

    #$time = $summary.time # Accessing time as a part of the $summary variable
    #$time
}

Get-Weather