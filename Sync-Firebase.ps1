$firebaseBaseUrl = "https://temperaturas-dashboard-default-rtdb.firebaseio.com"

$fileHorizontales = "C:\Repos\TemperaturasRepo\ReporteTemperaturas.json"
$fileVerticales = "C:\Repos\TemperaturasRepo\ReporteVerticales.json"

try {
    if (Test-Path $fileHorizontales) {
        $jsonTemperaturas = Get-Content -Path $fileHorizontales -Raw
        Invoke-RestMethod -Uri "$firebaseBaseUrl/ReporteTemperaturas.json" -Method Put -Body $jsonTemperaturas -ContentType "application/json" | Out-Null
        Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] ReporteTemperaturas.json subido a Firebase con exito."
    } else {
        Write-Warning "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] No se encontro el archivo: $fileHorizontales"
    }

    if (Test-Path $fileVerticales) {
        $jsonVerticales = Get-Content -Path $fileVerticales -Raw
        Invoke-RestMethod -Uri "$firebaseBaseUrl/ReporteVerticales.json" -Method Put -Body $jsonVerticales -ContentType "application/json" | Out-Null
        Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] ReporteVerticales.json subido a Firebase con exito."
    } else {
        Write-Warning "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] No se encontro el archivo: $fileVerticales"
    }
} catch {
    Write-Error "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Error al subir a Firebase: $_"
}
