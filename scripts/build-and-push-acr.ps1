param(
    [string]$acrName = "pythonproj",      # change this
    [string]$acrResourceGroup = "rg1" # optional if you use az acr login
)

# Login to Azure (if not already logged in)
az account show 1>$null 2>$null
if ($LASTEXITCODE -ne 0) {
    az login
}

# Login to ACR
Write-Host "Logging into ACR: $acrName"
az acr login --name $acrName

# Build and push each image
$services = @(
    @{ name = "user-service"; path = "./user-service"; port = "5001" },
    @{ name = "product-service"; path = "./product-service"; port = "5002" },
    @{ name = "order-service"; path = "./order-service"; port = "5003" }
)

foreach ($s in $services) {
    $localTag = "ecommerce/$($s.name):latest"
    $acrTag = "$acrName.azurecr.io/ecommerce/$($s.name):v1"

    Write-Host "`nBuilding $($s.name) ..."
    docker build -t $localTag $s.path

    Write-Host "Tagging as $acrTag ..."
    docker tag $localTag $acrTag

    Write-Host "Pushing $acrTag ..."
    docker push $acrTag
}

Write-Host "All images pushed to ACR: $acrName.azurecr.io"
