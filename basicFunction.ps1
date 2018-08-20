# bacic function

#declaring function Get-Result
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

        # If elseif statements for comparing users input and performing the calculations  
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

        # Do while loop to ask user if they would like to make another calculation if input is wrong an error is thrown and asked to input again
        do
        {
            $x = Read-Host "Would you like to make another calculation? enter [Y] for yes or [N] to exit"

            if(($x -ine "Y") -and ($x -ine "N")) # if statement to check the users selection [Y] or [N] which is incase-sensitive
            {
                Write-Host "Error selection was not Y or N" # Error for if user inputs wrong selection
            }

        }while(($x -ine "Y") -and ($x -ine "N")) # While conditions to continue the loop if user input is NOT equal to [Y] or [N] 

    }while($x -ieq "Y") # While condition for if users input is EQUAL to [Y] to exit the loop
}

# Calling function passing two variables powershell dont use parenthesis () to pass arguments
Get-Result

write-host "---------------------`r`n"


   