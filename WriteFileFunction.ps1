function Write-ToFile # Function to write to file
{
    param(
        [string]$text,     # variable to hold text to insert into file
        [string]$fileName, # variable to hold file name

        # Validation of path input
        # tell Windows PowerShell to examine the parameter values that are used when the function is called and determine whether the parameter values meet some specified conditions.
        [ValidateScript({  
           
            #if statement to test if the $pathDirectory variable is NOT empty
            if(!($_ -eq '')){

                # If statement to test if a path is not valid and that it is not a file 
                if(!(Test-Path -path $_ -PathType container) ){    
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
        [String]$pathDirectory # Variable to hold path directory
    )

    # do-while loop to allow for correct input of [1] or [2] for creating a new file or append to a file
    do{
        $selection = Read-Host "Would you like to create a new file or append to an existing file? Select [1] for New or [2] for Append" # user input to select new file or append to an existing file

        # ifelse statement to compare user selection or throw an error if incorrect input has been entered
        if ($selection -eq 1) {
            
            # ifelse statement to check if path directory has been entered
            if(!$pathDirectory) {
                $text | Out-File $fileName
            }
            elseif($pathDirectory) {
                $Text | Out-File $pathDirectory$fileName
            }
        }
        elseif ($selection -eq 2) {

            # ifelse statement to check if path directory has been entered
            if(!$pathDirectory) {
                $text | Out-File $fileName -Append # Appends to a file using -Append
            }
            elseif($pathDirectory) {
                $Text | Out-File $pathDirectory$fileName -Append # Appends to a file using -Append
            }
        }

        else # else to throw an error
        {
            Write-Host "That selection dont exist please select either [1] or [2]"
        }

    }while(($selection -ne 1) -and ($selection -ne 2))
}

# Function for user input
function User-Input
{

# Variables to hold user inputs
$text = Read-Host "Please enter text to write to file"
$fileName = Read-Host "Please enter a file name including extention type"
$pathDirectory = Read-Host "Please enter path to save file [Leave blank to save in current working directory]" 


# Calling write-ToFile function passing three variables
Write-ToFile -text $text -filename $fileName -pathDirectory $pathDirectory

}

User-Input
