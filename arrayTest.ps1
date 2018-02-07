# learn-powershell-array-examples-1
# create simple array of strings 
$myArray = @("abc", "xyz", "lmn", "pqr")

# print lenghth of array
$myArray.Length

# print a new line 'r'n 
Write-Host "`r"

# show array
$myArray

write-host "---------single element----------"

# Retrieve my second elemant of array
$myArray[1]

# print to screen
Write-Host "-----------first update---------"

# update a single element in an array
$myArray[2] = "ghi"

$myArray

# print to screen
Write-Host "-----------Add element to end of array---------"

#adding a new value to a fixed array 
$myArray += "jkl"

$myArray

# print to screen
Write-Host "-----------Second update---------"

# update multiple elements of an array will add 2 elements into the array from position 2 leaving the last element
$myArray[2] = "lmo", "efg"

$myArray

# print a new line 'r'n 
Write-Host "`n"

# print lenghth of array
$myArray.Length

# get type of array
$myArray.GetType()


