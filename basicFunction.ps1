# bacic function

#declaring function Get-TimesResult
function Get-TimesResult([int]$a,[int]$b)
{  
    $x = 0

    do
    { 
        # Variables for taking in user inputs
        $a = Read-Host "Please input first number `r"
        $b = Read-Host "Please input second number `r"

        # variable for user selection of computation 
        $choice = Read-Host "Would you like to add [1], subtract [2], divide [3] or multiply [4]?" 

        # If elseif statements  
        if($choice -eq "1")
        {
            $c = $a + $b 
            Write-Host $c "`r`n"
        }
        elseif($choice -eq "2")
        {
            $c = $a - $b 
            Write-Host $c "`r`n"
        }
        elseif($choice -eq "3")
        {
            $c = $a / $b 
            Write-Host $c "`r`n"
        }
        elseif($choice -eq "4")
        {
            $c = $b * $a
            Write-Host $c "`r`n"
        }
        else
        {
            Write-Host "Error selection was not 1 - 4"
        }

        do
        {
            $x = Read-Host "Would you like to make another calculation? enter [Y] for yes or [N] to exit"

            if(($x -ine "Y") -and ($x -ine "N"))
            {
                Write-Host "Error selection was not 0 or 1"
            }


        }while(($x -ine "Y") -and ($x -ine "N"))

    }while($x -ieq "Y")
}

# Calling function passing two variables powershell dont use parenthesis () to pass arguments
Get-TimesResult

write-host "---------------------`r`n"


   