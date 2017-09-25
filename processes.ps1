$services = Get-Service | Select-Object displayName, Status | ConvertTo-Html -Fragment

$process = get-process | Select-Object Name, CPU | sort-object CPU -Descending | ConvertTo-Html -Fragment

$services = $services | foreach {
    $_ -replace "<td>Running</td>", "<td style=`"color: green`">Running</td>"
}

$services = $services | foreach {
    $_ -replace "<td>Stopped</td>", "<td style=`"color: red`">Stopped</td>"
}

$HTML = ConvertTo-Html -Body "$services $process" -Head "<style> body {background-color: lightblue; } table {background-color: white; margin: 5px; float: left; top: 0px; display: inline-block; padding: 5px; border: 1px solid black} tr:nth-child(odd) {background-color: lightgray} </style>"

#Output to a file
$HTML | Out-File $filePath
