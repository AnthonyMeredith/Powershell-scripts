# if else examples

# Example 1

# using a i in the comparison makes the comparison case insensitive
if ("ABC" -ieq "abc") # if statement to compare the uppercase ABC to the lowercase abc and is incase sensitive
{

    Write-Host "Example 1 -condition satisfied `r" -ForegroundColor Green # writing to screen if condition is met and making the text colour green

}
else
{
    Write-Host "Example 1 -condition NOT satisfied `r" -ForegroundColor Red # writing to screen if condition is  NOT met and making the text colour red
}

# using a c in the comparison makes the comparison case sensitive
if ("ABC" -ceq "abc") # if statement to compare the uppercase ABC to the lowercase abc and is case sensitive
{

    Write-Host "Example 2 -condition satisfied `r" -ForegroundColor Green # writing to screen if condition is met and making the text colour green

}
else
{
    Write-Host "Example 2 -condition NOT satisfied `r" -ForegroundColor Red # writing to screen if condition is NOT met and making the text colour red
}