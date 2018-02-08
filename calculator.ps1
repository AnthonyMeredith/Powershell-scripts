#declaring function Get-TimesResult
function Get-Calculation
{  
    # Declaring paramerters for the function
    param([ValidatePattern("\d+\s*[\*\+\-\/]\s*\d+")]
          [string]$calculate)

    
    # regex to extract three groups first numbers in string symbol for calculation and the second set of numbers
    $b = $calculate -split '(\d+)\s*([\*\+\-\/])\s*(\d+)'
    $total = 0

    $operator = [char]$b[2] # Putting extracted symbol into a variable for comparison
    $num1 = [int]$b[1]      # putting first number into a variable for later calculation
    $num2 = [int]$b[3]      # putting second number into a variable for later calculation


    # Elseif statements to compare symbols for calculation 
    if($operator -eq "+")
    {
        $total = ($num1 + $num2) 
    }
    elseif($operator -eq "-")
    {
        $total = ($num1 - $num2)
    }
    elseif($operator -eq "/")
    {
        $total = ($num1 / $num2)
    }
    elseif($operator -eq "*")
    {
        $total = ($num1 * $num2)
    }
    else
    {
        Write-Host "Error input was incorrect must be number symbol number input"
    }

    return $total # returning total from the calculations no need to return total under each if statement
   
}

# Do while loop to allow for multiple calculations depending on if user wants to
do
{ 

    # Variables for taking in user input string
    $calculation = Read-Host "Please enter your calculation e.g 1*1 use symbols [+ - / *] `r"

    $tot = Get-Calculation -calculate $calculation # making $tot equal to the value returned from calculation function and Calling function passing variable -calculate, powershell dont use parenthesis () to pass arguments

    write-host "Total = $tot `r`r"

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


 

write-host "---------------------`r`n"
