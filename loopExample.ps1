# loop examples

$i = 1

while ($i -le 5)
{
    if ($i -eq 5)
    {
        Write-Host "$i is equal to 5 loop complete `r`n"
        break;
    }
    else
    {
        Write-Host "$i is less than 5 incrimenting `$i `r`n"
        $i ++;
    }
}

Write-Host "-------------------`r"
$i = 1

do {
    if ($i -eq 5)
    {
        Write-Host "$i is equal to 5 loop complete `r`n"
        break;
    }
    else
    {
        Write-Host "$i is less than 5 incrimenting `$i `r`n"
        $i ++;
    }
}while ($i -le 5)

Write-Host "-------------------`r"


for($i=1; $i -le 5; $i++) {
    if ($i -eq 5)
    {
        Write-Host "$i is equal to 5 loop complete `r`n"
        break;
    }
    else
    {
        Write-Host "$i is less than 5 incrimenting `$i `r`n"
    }
}
