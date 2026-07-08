[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
$srcPath = "d:\project\RimonAyurbedic\public\assets\feature-graphic.jpg"
$destPath = "d:\project\RimonAyurbedic\public\assets\feature-graphic.jpg"
$downloadsPath = "C:\Users\IMRAN\Downloads\Rimon - Google Play package\feature-graphic-1024x500.jpg"

$srcImg = [System.Drawing.Image]::FromFile($srcPath)
$croppedImg = New-Object System.Drawing.Bitmap(1024, 500)
$graph = [System.Drawing.Graphics]::FromImage($croppedImg)

$srcRect = New-Object System.Drawing.Rectangle(0, 262, 1024, 500)
$destRect = New-Object System.Drawing.Rectangle(0, 0, 1024, 500)

$graph.DrawImage($srcImg, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)

$graph.Dispose()
$srcImg.Dispose()

$croppedImg.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$croppedImg.Dispose()

Copy-Item $destPath $downloadsPath -Force
Write-Host "Success"
