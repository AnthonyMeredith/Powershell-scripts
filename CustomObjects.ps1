
# Creating custom objects
$system = New-Object -TypeName PSObject # Creating new object based on the PSObject class
$systemFile = ConvertTo-Json -Depth 3 $system # Converting the data in $system variable to json and putting it into a variable
Set-Content Result.json $systemFile # outputting to result file

$os = Get-WmiObject Win32_OperatingSystem # Creating a Win32_OperatingSystem WMI object 
$wmiObject = ConvertTo-Json -Depth 3 $os # Converting the data $os variable to json and putting it into a variable
Set-Content Result2.json $wmiObject # outputting to result2 file

Add-Member -InputObject $system -MemberType NoteProperty `
  -Name OperatingSystem -Value $os.Caption # Creating a new member in the $system array using the data from the $os.Caption section of the $os variable
Add-Member -InputObject $system -MemberType NoteProperty `
  -Name ServicePack -Value $os.CSDVersion # Creating a new member in the $system array using the data from the $os.CSDVersion section of the $os variable

$system.OperatingSystem # Printing out the OperatingSystem member of the system variable using dot notation

$systemFile = ConvertTo-Json -Depth 3 $system # Converting the data in $system variable to json and putting it into a variable
Set-Content Result3.json $systemFile # outputting to result file