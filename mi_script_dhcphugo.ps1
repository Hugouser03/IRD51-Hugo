# Script PowerShell - Configuración de Ámbito DHCP "RedInterna"

Import-Module DHCPServer

# 21. Crear nuevo ámbito DHCP llamado RedInterna
Add-DhcpServerv4Scope -Name "RedInterna" -StartRange 50.0.10.3 -EndRange 50.0.10.100 -SubnetMask 255.255.255.0

# 22. Configurar puerta de enlace predeterminada
Set-DhcpServerv4OptionValue -ScopeId 50.0.10.0 -Router 50.0.10.254

# 23. Agregar servidor DNS
Set-DhcpServerv4OptionValue -ScopeId 50.0.10.0 -DnsServer 50.0.10.3

# 24. Activar el ámbito
Set-DhcpServerv4Scope -ScopeId 50.0.10.0 -State Active

# 25. Ver todos los ámbitos configurados
Get-DhcpServerv4Scope

# 26. Eliminar ámbito llamado Antiguo
Remove-DhcpServerv4Scope -ScopeId 192.168.50.0 -Force

# 27. Verificar concesiones activas
Get-DhcpServerv4Lease -ScopeId 50.0.10.0

# 28. Reservar IP 50.0.10.6 para MAC 00-11-22-33-44-55
Add-DhcpServerv4Reservation -ScopeId 50.0.10.0 -IPAddress 50.0.10.6 -ClientId "00-11-22-33-44-55" -Description "Reserva para cliente específico" -Name "Cliente01"

# 29. Desactivar el ámbito temporalmente
Set-DhcpServerv4Scope -ScopeId 50.0.10.0 -State Inactive

# 30. Exportar configuración DHCP a XML
New-Item -ItemType Directory -Path "C:\backup" -Force
Export-DhcpServer -ComputerName localhost -Leases -File "C:\backup\DHCP_Config.xml" -Force

