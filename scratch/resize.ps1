[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null

function Resize-Image {
    param (
        [string]$Path,
        [int]$Width,
        [int]$Height
    )
    $srcImg = [System.Drawing.Image]::FromFile($Path)
    $resizedImg = New-Object System.Drawing.Bitmap($Width, $Height)
    $graph = [System.Drawing.Graphics]::FromImage($resizedImg)
    
    $graph.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graph.DrawImage($srcImg, 0, 0, $Width, $Height)
    
    $graph.Dispose()
    $srcImg.Dispose()
    
    # Save to a temporary path first to avoid file-lock issues
    $tempPath = $Path + ".tmp"
    $resizedImg.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $resizedImg.Dispose()
    
    Remove-Item $Path
    Rename-Item $tempPath (Split-Path $Path -Leaf)
}

# Resize project assets
Resize-Image "d:\project\RimonAyurbedic\public\assets\screenshot-mobile.jpg" 1200 1200
Resize-Image "d:\project\RimonAyurbedic\public\assets\screenshot-mobile-2.jpg" 1200 1200
Resize-Image "d:\project\RimonAyurbedic\public\assets\screenshot-desktop.jpg" 1200 1200

# Copy to downloads folder for the user
Copy-Item "d:\project\RimonAyurbedic\public\assets\screenshot-mobile.jpg" "C:\Users\IMRAN\Downloads\Rimon - Google Play package\screenshot-mobile-1.jpg" -Force
Copy-Item "d:\project\RimonAyurbedic\public\assets\screenshot-mobile-2.jpg" "C:\Users\IMRAN\Downloads\Rimon - Google Play package\screenshot-mobile-2.jpg" -Force
Copy-Item "d:\project\RimonAyurbedic\public\assets\screenshot-desktop.jpg" "C:\Users\IMRAN\Downloads\Rimon - Google Play package\screenshot-desktop.jpg" -Force

Write-Host "Success"
