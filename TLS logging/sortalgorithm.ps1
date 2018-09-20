$list = @()

foreach ($c1 in $logValue[0]) {
    foreach ($c2 in $logValue[0]) {
        foreach ($c3 in $logValue[0]) {
            foreach ($c4 in $logValue[0]) {
                if (($c1 -ne $c2) -and ($c2 -ne $c3) -and ($c3 -ne $c4) -and ($c4 -ne $c1) -and ($c4 -ne $c2) -and ($c3 -ne $c1))
                {
                    $list += "$c1 $c2 $c3 $c4"

                    
                }
            }
        }
    }
} 

$list