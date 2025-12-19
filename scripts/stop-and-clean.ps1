Write-Host "Stopping containers..."
docker compose down

Write-Host "Optional: remove built images? (y/N)"
$response = Read-Host
if ($response -eq "y") {
    docker rmi ecommerce/user-service:local -f -a
    docker rmi ecommerce/product-service:local -f -a
    docker rmi ecommerce/order-service:local -f -a
    Write-Host "Images removed."
}
