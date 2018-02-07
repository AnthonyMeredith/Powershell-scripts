# bacic function

#declaring function Get-TimesResult
function Get-TimesResult
{  
    # Declaring paramerters for the function
    param([ValidatePattern("\d+\s*[\*\+\-\/]\s*\d+")]
          [string]$a)

    # initilsing $x variable to zero
    $x = 0

    # Do while loop to allow for multiple calculations depending on if user wants to
    do
    { 
        # Variables for taking in user input string
        $a = Read-Host "Please enter your calculation e.g 1*1 use symbols [+ - / *] `r"

        # regex to extract three groups first numbers in string symbol for calculation and the second set of numbers
        $b = $a -split '(\d+)\s*([\*\+\-\/])\s*(\d+)'

        $operator = [char]$b[2] # Putting extracted symbol into a variable for comparison
        $num1 = [int]$b[1]      # putting first number into a variable for later calculation
        $num2 = [int]$b[3]      # putting second number into a variable for later calculation


        # Elseif statements to compare symbols for calculation 
        if($operator -eq "+")
        {
            $total = ($num1 + $num2)
            Write-Output $total "`r`n"
        }
        elseif($operator -eq "-")
        {
            $total = ($num1 - $num2)
            Write-Output $total "`r`n"
        }
        elseif($operator -eq "/")
        {
            $total = ($num1 / $num2)
            Write-Output $total "`r`n"
        }
        elseif($operator -eq "*")
        {
            $total = ($num1 * $num2)
            Write-Output $total "`r`n"
        }
        else
        {
            Write-Host "Error input was incorrect must be number symbol number input"
        }

        # Do while loop to ask user if they would like to make another calculation if input is wrong an error is thrown and asked to input again
        do
        {
            $x = Read-Host "Would you like to make another calculation? enter [Y] for yes or [N] to exit"

            if(($x -ine "Y") -and ($x -ine "N"))
            {
                Write-Host "Error selection was not Y or N"
            }


        }while(($x -ine "Y") -and ($x -ine "N"))

    }while($x -ieq "Y")
}

# Calling function passing two variables powershell dont use parenthesis () to pass arguments
Get-TimesResult

write-host "---------------------`r`n"
