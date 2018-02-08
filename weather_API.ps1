

function Get-weather {

    param([string]$apiKey

    )

    #$apikey = Read-Host "Please enter Dark Sky API key"

    #if ($apikey -ne 1) {

        Invoke-RestMethod "https://api.darksky.net/forecast/1f76693d9f8a17cd11aab3871527b2fe/51.481581,-3.1790,255657600?exclude=currently,flags9"

}

Get-Weather