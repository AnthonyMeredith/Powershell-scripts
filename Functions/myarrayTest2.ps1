# learn-powershell-array-examples-1
# Delcaring an array using a range 
$myArray = 1..8
$myArray

Write-Host "----------------`r"
$myArray2 = 3..8
$myArray


Write-Host "----------------`r"
$myArray3 = 14..8
$myArray

Write-Host "----------------`r"

# concatinating arrays
$myArray4 = $myArray += $myArray2 += $myArray3
$myArray4

Write-Host "----------------`r"

# Declaring an array to be able to use .add() and .remove()
$items = "item1", "item2", "item3", "item4"
$items.GetType() # .GetType() shows the variable type of a variable $items is in this case will be an object[] (this is the class type of the variable) and basetype is a System.Array

[System.Collections.ArrayList]$arrayList = $Items
$arrayList.GetType() # .GetType() shows the variable type of a variable $arrayList is in this case will be an ArrayList (this is the class type of the variable) and basetype is a System.Object

$arrayList.Add("Item5") # Adds an item to an array 

$arrayList

Write-Host "----------------`r"

$arrayList.Remove("item3") # Removes an item from an array

$arrayList

Write-Host "----------------`r"

# Declaring an empty array which can use add remove functions can also use $newTab = New-Object System.Collections.ArrayList
$arrayList2 = [System.Collections.ArrayList]::new() # Creating a new array and calling the Static method of the System.Collections.ArrayList class can also be done using New-Object System.Collections.ArrayList
$arrayList2 # Prints the empty array

$arrayList2.Add("Item5") # Adds Item5 to the array
$arrayList2 # Prints the array with the new value in it