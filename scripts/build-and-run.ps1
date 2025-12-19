# Requires Docker Desktop (or Docker Engine) and docker-compose available
$ErrorActionPreference = "Stop"

Write-Host "Building and starting containers with docker-compose..."
docker compose build --parallel
docker compose up -d

Write-Host "Waiting for services to be healthy..."
Start-Sleep -Seconds 5

# Show container status
docker ps --filter "name=ecommerce" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

Write-Host "Services should be available at:"
Write-Host " - User Service: http://localhost:5001"
Write-Host " - Product Service: http://localhost:5002"
Write-Host " - Order Service: http://localhost:5003"
