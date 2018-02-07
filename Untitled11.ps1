#$input1 = Get-Content env:computername

#$input3 = Get-Content env:datetime
#Write-Host $input1
$input2 = "Hello" 

$input = Read-Host "please enter what you want to write to file"
$fileName = Read-Host "Please enter a file name"
$pathName = Read-Host "Please enter file path"

$input | Out-File $fileName # Out-File CMDLET will create a file and write to it 

#$input2 +"`r"+ $input1 | Out-File C:\Users\AnthonyMeredith\Desktop\powershellExamples\file.txt -Append # Appends to a file usinf 



$a = Read-Host "would you like to read from file?"

if ($a -ieq "Y") {

    write-host $pathName $fileName

    Get-Content -Path "$pathName$fileName"

}