$taskName = "Sync-Firebase-Temperaturas"
$scriptPath = "C:\Repos\TemperaturasRepo\Sync-Firebase.ps1"

# Acción: Ejecutar PowerShell oculto
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptPath`""

# Disparador: Comenzar de inmediato y repetir cada 5 minutos indefinidamente
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5)

# Opciones adicionales: Permitir ejecución en batería y ejecutar tan pronto esté disponible
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -MultipleInstances IgnoreNew

# Registrar la tarea programada usando el usuario actual (sin pedir contraseña si no es necesario, o puede ajustarse)
try {
    Register-ScheduledTask -TaskName $taskName -Action $Action -Trigger $Trigger -Settings $Settings -RunLevel Highest -Force
    Write-Host "Tarea programada '$taskName' creada exitosamente. Se ejecutará cada 5 minutos." -ForegroundColor Green
} catch {
    Write-Error "Hubo un error al crear la tarea programada: $_"
}
