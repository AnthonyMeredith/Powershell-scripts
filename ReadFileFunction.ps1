# function to read from a file
function Read-FromFile
{
    param(

        # Validation of path input
        # tell Windows PowerShell to examine the parameter values that are used when the function is called and determine whether the parameter values meet some specified conditions.
        [ValidateScript({  
           
            #if statement to test if the $pathDirectory variable is NOT empty
            if(!($_ -eq '')){

                # If statement to test if a path is not valid and that it is not a file 
                if(!(Test-Path -path $_) ){    
                    throw "Path entered is not a valid directory" # throwing an error if not a valid path to a directory
                }

                #else for if path is valid return true and continue with code
                else{
                    return $True
                }
            }

            # else if path entered is empty reture true and continue on with code file will be placed in working directory
            else{
                return $True
            }
        })]
        [String]$filePath # Variable to hold path directory
    )

    # Do-while loop to allow for user input if wrong selection is made 
    do
    {
        # variable to hold user selection
        $userChoice = Read-Host "`nWould you like to read a full text file enter [1], Choose a line number enter [2] or search for lines with a specific word enter [3]"

        # If statement to ceck user input and perform the correct task
        if($userChoice -eq 1)
        {
            Get-Content -path $pathToFile # Get-Content -path "C:\Users\AnthonyMeredith\Desktop\powershellExamples\Test.txt" # How to hard code the file into the code
        }
        elseif($userChoice -eq 2)
        {
            # Do-While loop for if a selected line is empty to ask the user to choose another line
            do
            {
                $lineNumber = Read-Host "`nPlease enter the line number you would read" # variable to hold users line number choice
                $inputText = Get-Content -path $pathToFile # Variable to hold the the text from the chosen file
                $outputText = $inputText[$lineNumber] # Variable to hold the chosen line of the text file
                #clear # clear console screen
                Write-Host "`nThat line of the text file is empty. Please enter another line" # output to tell user that their selected line of the file is empty

            }while(!$outputText) 

            # If statement to check if the chosen contains text
            if($outputText)
            {
                #clear # clear console screen
                Write-Host $inputText[$lineNumber] # Write to screen the line the user has selected
            }
        } 
        elseif($userChoice -ieq 3)
        {
            $chosenWord = Read-Host "`nPlease enter the word you would like to find" # variable to hold the users choosen word to search for

            #Get-Content $pathToFile | % { if($_ -match $chosenWord) {write-host $_}} is another way to carry out the foreach loop and the % symbol is an alias ForEach-Object

            $inputText = get-content $pathToFile # Variable to hold the text from the users chosen file

            # If statement to check if the word is present in the chosen file 
            if(!($inputText -match $chosenWord)) # 
            {
                Write-Host "Word does not exist in chosen file"
            }
            else
            {
                foreach ($line in $inputText) # foreach loop to go through each line in the file storing each line in the $line variable
                { 
                    # If statement to check if the word is present in the current line stored in the $line variable
                    if ($line -imatch "(?<![\w\d])$chosenWord(?![\w\d])")
                    {
                        Write-Host "`n"$line # If the chosen word is present in the current line then print it to screen
                    }
                }
            }
        }
        else
        {
            #clear # Clear console screen
            Write-Host "`nERROR please enter a valid input [1], [2] or [3]" # Write error message to screen and to remind the user of the choice of input
        }
    }while(($userChoice -ne 1) -and ($userChoice -ne 2) -and ($userChoice -ne 3))# Do-While conditionals to check if user input is not equal to [1], [2] or [3]
}

$pathToFile = Read-Host "Please input the path to the file you want to read from [Just enter the file name if it's in your working directory]" # Variable to hold path to file user wants to access

Read-FromFile -filePath $pathToFile # Calling function 