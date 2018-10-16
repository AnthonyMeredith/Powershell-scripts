$names = @()
$newNames = @()

foreach($name in $names)
{
    $newNames += "$name@example.com`r"

}
    $newNames | Out-File -filepath C:\email.txt