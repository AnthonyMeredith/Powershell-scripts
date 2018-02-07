function Write-ToFile #([string]$text, [string]$fileName, [string]$pathDirectory)
{
    param(
        [string]$input,
        [string]$pathDirectory,
        [string]$fileName
    )

    #Write-Host $fileName
    #Write-Host $text

    $selection = Read-Host "Would you like to create a new file or append to an existing file? Select [1] for New or [2] for Append"

    if ($selection -eq 1) {

        if(!$pathDirectory) {
            $text | Out-File $fileName
        }
        elseif($pathDirectory) {
            $Text | Out-File $pathDirectory$fileName
        }
    }
    elseif ($selection -eq 2) {

        if(!$pathDirectory) {
            $text | Out-File $fileName -Append # Appends to a file using -Append
        }
        elseif($pathDirectory) {
            $Text | Out-File $pathDirectory$fileName -Append
        }
    }
}

$text = Read-Host "Please enter text to write to file"
$fileName = Read-Host "Please enter a file name"
$pathDirectory = Read-Host "Please enter path to save file [Leave blank to save in current working directory]"

#Write-Host $fileName
#Write-Host $text

Write-ToFile -text $text -filename $fileName -pathDirectory $pathDirectory