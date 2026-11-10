Add-Type -AssemblyName System.Drawing

function Draw-KebunCabai {
    param([string]$outputPath)
    $bmp = New-Object System.Drawing.Bitmap 800, 420
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    # Sky gradient
    $skyBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush (New-Object System.Drawing.Point 0, 0), (New-Object System.Drawing.Point 0, 260), ([System.Drawing.Color]::FromArgb(255, 56, 189, 248)), ([System.Drawing.Color]::FromArgb(255, 224, 242, 254))
    $g.FillRectangle($skyBrush, 0, 0, 800, 260)
    $skyBrush.Dispose()

    # Sun
    $sunBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(240, 254, 240, 138))
    $g.FillEllipse($sunBrush, 650, 30, 80, 80)
    $sunBrush.Dispose()

    # Mountains
    $mountainBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 34, 112, 73))
    $points1 = @(
        (New-Object System.Drawing.Point 0, 260),
        (New-Object System.Drawing.Point 180, 160),
        (New-Object System.Drawing.Point 360, 220),
        (New-Object System.Drawing.Point 580, 140),
        (New-Object System.Drawing.Point 800, 230),
        (New-Object System.Drawing.Point 800, 260)
    )
    $g.FillPolygon($mountainBrush, $points1)
    $mountainBrush.Dispose()

    # Soil Ground
    $soilBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush (New-Object System.Drawing.Point 0, 240), (New-Object System.Drawing.Point 0, 420), ([System.Drawing.Color]::FromArgb(255, 101, 52, 25)), ([System.Drawing.Color]::FromArgb(255, 45, 26, 13))
    $g.FillRectangle($soilBrush, 0, 240, 800, 180)
    $soilBrush.Dispose()

    # Mulch bedengan
    $mulchBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush (New-Object System.Drawing.Point 0, 250), (New-Object System.Drawing.Point 0, 420), ([System.Drawing.Color]::FromArgb(255, 148, 163, 184)), ([System.Drawing.Color]::FromArgb(255, 71, 85, 105))
    $g.FillPolygon($mulchBrush, @(
        (New-Object System.Drawing.Point 60, 420),
        (New-Object System.Drawing.Point 280, 420),
        (New-Object System.Drawing.Point 250, 250),
        (New-Object System.Drawing.Point 140, 250)
    ))
    $g.FillPolygon($mulchBrush, @(
        (New-Object System.Drawing.Point 460, 420),
        (New-Object System.Drawing.Point 680, 420),
        (New-Object System.Drawing.Point 580, 250),
        (New-Object System.Drawing.Point 470, 250)
    ))
    $mulchBrush.Dispose()

    # Plants
    $leafBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 34, 139, 34))
    $darkLeaf = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 20, 83, 45))
    $redChili = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 220, 38, 38))
    $chiliStem = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(255, 16, 185, 129)), 3

    $plantsX = @(160, 210, 500, 560, 180, 540)
    $plantsY = @(330, 280, 320, 270, 370, 360)
    $sizes   = @(65, 45, 65, 45, 80, 80)

    for ($i = 0; $i -lt $plantsX.Count; $i++) {
        $px = $plantsX[$i]
        $py = $plantsY[$i]
        $sz = $sizes[$i]
        $g.FillEllipse($darkLeaf, [int]($px - $sz/2), [int]($py - $sz/2), [int]$sz, [int]$sz)
        $g.FillEllipse($leafBrush, [int]($px - $sz/3), [int]($py - $sz/3 - 8), [int]($sz * 0.8), [int]($sz * 0.8))

        $g.DrawLine($chiliStem, [int]($px - 10), [int]$py, [int]($px - 8), [int]($py + 10))
        $g.FillEllipse($redChili, [int]($px - 14), [int]($py + 8), 12, 28)

        $g.DrawLine($chiliStem, [int]($px + 12), [int]($py - 4), [int]($px + 15), [int]($py + 6))
        $g.FillEllipse($redChili, [int]($px + 10), [int]($py + 5), 12, 26)
    }

    # Overlay badge
    $tagBg = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(190, 15, 23, 42))
    $g.FillRectangle($tagBg, 0, 350, 800, 70)
    $tagBg.Dispose()

    $fontTitle = New-Object System.Drawing.Font 'Arial', 14, ([System.Drawing.FontStyle]::Bold)
    $fontSub   = New-Object System.Drawing.Font 'Arial', 10, ([System.Drawing.FontStyle]::Regular)
    $whiteBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
    $goldBrush  = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 254, 240, 138))

    $g.DrawString('PANDUAN LAPANGAN BUDIDAYA CABAI SEHAT', $fontTitle, $goldBrush, 24, 360)
    $g.DrawString('Identifikasi & Pengendalian Terpadu Hama Penyakit Cabai (Capsicum annuum)', $fontSub, $whiteBrush, 24, 388)

    $fontTitle.Dispose()
    $fontSub.Dispose()
    $whiteBrush.Dispose()
    $goldBrush.Dispose()
    $leafBrush.Dispose()
    $darkLeaf.Dispose()
    $redChili.Dispose()
    $chiliStem.Dispose()
    $g.Dispose()

    $bmp.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

function Draw-CardIllustration {
    param(
        [string]$outputPath,
        [string]$title,
        [string]$subtitle,
        [string]$categoryText,
        [System.Drawing.Color]$mainColor,
        [System.Drawing.Color]$bgColor,
        [string]$type
    )

    $bmp = New-Object System.Drawing.Bitmap 600, 600
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    # Background gradient
    $bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush (New-Object System.Drawing.Point 0, 0), (New-Object System.Drawing.Point 600, 600), $bgColor, ([System.Drawing.Color]::FromArgb(255, 248, 250, 252))
    $g.FillRectangle($bgBrush, 0, 0, 600, 600)
    $bgBrush.Dispose()

    # Decorative circles
    $decBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(35, $mainColor.R, $mainColor.G, $mainColor.B))
    $g.FillEllipse($decBrush, 300, -50, 350, 350)
    $g.FillEllipse($decBrush, -80, 280, 300, 300)
    $decBrush.Dispose()

    # Visual Drawing by Type
    if ($type -eq 'gemini') {
        # Virus Gemini: Daun kuning melengkung keriting dengan urat daun hijau pucat
        $leafBg = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 234, 179, 8)) # Yellow bule
        $leafPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(255, 161, 98, 7)), 4
        $veinPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(255, 133, 77, 14)), 3

        # Big leaf shape
        $pts = @(
            (New-Object System.Drawing.Point 300, 100),
            (New-Object System.Drawing.Point 420, 180),
            (New-Object System.Drawing.Point 440, 320),
            (New-Object System.Drawing.Point 300, 420),
            (New-Object System.Drawing.Point 160, 320),
            (New-Object System.Drawing.Point 180, 180)
        )
        $g.FillClosedCurve($leafBg, $pts)
        $g.DrawClosedCurve($leafPen, $pts)

        # Leaf vein
        $g.DrawLine($veinPen, 300, 110, 300, 410)
        $g.DrawLine($veinPen, 300, 200, 380, 170)
        $g.DrawLine($veinPen, 300, 200, 220, 170)
        $g.DrawLine($veinPen, 300, 280, 400, 260)
        $g.DrawLine($veinPen, 300, 280, 200, 260)
        $g.DrawLine($veinPen, 300, 340, 380, 330)
        $g.DrawLine($veinPen, 300, 340, 220, 330)

        # Whitefly vector illustration on leaf
        $flyBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
        $flyPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(255, 200, 200, 200)), 1
        $g.FillEllipse($flyBrush, 360, 240, 22, 14)
        $g.DrawEllipse($flyPen, 360, 240, 22, 14)
        $g.FillEllipse($flyBrush, 230, 290, 20, 12)

        $leafBg.Dispose(); $leafPen.Dispose(); $veinPen.Dispose(); $flyBrush.Dispose(); $flyPen.Dispose()
    }
    elseif ($type -eq 'antraknosa') {
        # Antraknosa: Buah cabai merah dengan bercak patek melingkar cekung hitam
        $chiliBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush (New-Object System.Drawing.Point 200, 120), (New-Object System.Drawing.Point 400, 420), ([System.Drawing.Color]::FromArgb(255, 239, 68, 68)), ([System.Drawing.Color]::FromArgb(255, 185, 28, 28))
        $stemBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 22, 163, 74))

        # Chili shape
        $cpts = @(
            (New-Object System.Drawing.Point 280, 110),
            (New-Object System.Drawing.Point 340, 110),
            (New-Object System.Drawing.Point 380, 220),
            (New-Object System.Drawing.Point 360, 360),
            (New-Object System.Drawing.Point 300, 450),
            (New-Object System.Drawing.Point 240, 360),
            (New-Object System.Drawing.Point 230, 220)
        )
        $g.FillClosedCurve($chiliBrush, $cpts)

        # Stem
        $g.FillRectangle($stemBrush, 295, 75, 16, 40)

        # Antracnose sunken concentric necrotic rings (Patek)
        $spotDark = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(240, 30, 20, 20))
        $ringPen1 = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(220, 180, 83, 9)), 4
        $ringPen2 = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(220, 69, 10, 10)), 3

        # Big circular patek lesion
        $g.FillEllipse($spotDark, 260, 220, 95, 80)
        $g.DrawEllipse($ringPen1, 260, 220, 95, 80)
        $g.DrawEllipse($ringPen2, 275, 235, 65, 50)
        $g.DrawEllipse($ringPen1, 290, 248, 35, 25)

        # Smaller secondary lesion
        $g.FillEllipse($spotDark, 285, 330, 50, 45)
        $g.DrawEllipse($ringPen1, 285, 330, 50, 45)

        $chiliBrush.Dispose(); $stemBrush.Dispose(); $spotDark.Dispose(); $ringPen1.Dispose(); $ringPen2.Dispose()
    }
    elseif ($type -eq 'bercak_daun') {
        # Cercospora: Daun hijau segar dengan bintik bulat coklat mata katak
        $leafBg = New-Object System.Drawing.Drawing2D.LinearGradientBrush (New-Object System.Drawing.Point 160, 100), (New-Object System.Drawing.Point 440, 430), ([System.Drawing.Color]::FromArgb(255, 74, 222, 128)), ([System.Drawing.Color]::FromArgb(255, 22, 163, 74))
        $pts = @(
            (New-Object System.Drawing.Point 300, 90),
            (New-Object System.Drawing.Point 430, 180),
            (New-Object System.Drawing.Point 440, 330),
            (New-Object System.Drawing.Point 300, 430),
            (New-Object System.Drawing.Point 160, 330),
            (New-Object System.Drawing.Point 170, 180)
        )
        $g.FillClosedCurve($leafBg, $pts)

        # Cercospora "Frog-eye" circular spots
        $outerSpot = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 120, 53, 15))
        $paleCenter = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 254, 243, 199))

        # Spots collection
        $spots = @(
            @(250, 200, 42, 38),
            @(330, 250, 48, 44),
            @(240, 310, 36, 32),
            @(350, 160, 30, 28),
            @(290, 360, 28, 26)
        )
        foreach ($s in $spots) {
            $x = $s[0]; $y = $s[1]; $w = $s[2]; $h = $s[3]
            $g.FillEllipse($outerSpot, $x, $y, $w, $h)
            $g.FillEllipse($paleCenter, [int]($x + $w*0.25), [int]($y + $h*0.25), [int]($w*0.5), [int]($h*0.5))
        }

        $leafBg.Dispose(); $outerSpot.Dispose(); $paleCenter.Dispose()
    }
    elseif ($type -eq 'kutu_daun') {
        # Kutu Daun (Aphids): Koloni serangga aphids hijau/hitam di daun muda keriting
        $curlLeaf = New-Object System.Drawing.Drawing2D.LinearGradientBrush (New-Object System.Drawing.Point 150, 120), (New-Object System.Drawing.Point 450, 400), ([System.Drawing.Color]::FromArgb(255, 134, 239, 172)), ([System.Drawing.Color]::FromArgb(255, 74, 222, 128))
        $pts = @(
            (New-Object System.Drawing.Point 300, 120),
            (New-Object System.Drawing.Point 430, 220),
            (New-Object System.Drawing.Point 410, 360),
            (New-Object System.Drawing.Point 280, 410),
            (New-Object System.Drawing.Point 170, 330),
            (New-Object System.Drawing.Point 190, 200)
        )
        $g.FillClosedCurve($curlLeaf, $pts)

        # Draw colony of aphids (pear-shaped oval bodies)
        $aphidGreen = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 34, 85, 34))
        $aphidBlack = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 30, 30, 30))
        $honeydew = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(180, 255, 255, 255))

        # Clusters
        $aphidCoords = @(
            @(270, 220, $true), @(285, 235, $false), @(305, 215, $true), @(320, 230, $false),
            @(295, 250, $true), @(260, 260, $false), @(280, 280, $true), @(310, 275, $true),
            @(335, 265, $false), @(300, 305, $true), @(325, 310, $false), @(270, 320, $true)
        )
        foreach ($a in $aphidCoords) {
            $ax = $a[0]; $ay = $a[1]; $isGreen = $a[2]
            $brush = if ($isGreen) { $aphidGreen } else { $aphidBlack }
            $g.FillEllipse($brush, $ax, $ay, 18, 24)
            # Legs
            $legPen = New-Object System.Drawing.Pen $brush.Color, 2
            $g.DrawLine($legPen, [int]($ax-4), [int]($ay+6), [int]($ax+4), [int]($ay+6))
            $g.DrawLine($legPen, [int]($ax-5), [int]($ay+14), [int]($ax+4), [int]($ay+14))
            $legPen.Dispose()
        }

        # Honeydew shiny droplets
        $g.FillEllipse($honeydew, 340, 210, 10, 10)
        $g.FillEllipse($honeydew, 250, 290, 8, 8)
        $g.FillEllipse($honeydew, 350, 295, 12, 12)

        $curlLeaf.Dispose(); $aphidGreen.Dispose(); $aphidBlack.Dispose(); $honeydew.Dispose()
    }
    elseif ($type -eq 'lalat_buah') {
        # Lalat Buah: Buah cabai dengan lalat buah bertengger dan tusukan ovipositor
        $chiliBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush (New-Object System.Drawing.Point 200, 130), (New-Object System.Drawing.Point 400, 420), ([System.Drawing.Color]::FromArgb(255, 249, 115, 22)), ([System.Drawing.Color]::FromArgb(255, 220, 38, 38))
        $pts = @(
            (New-Object System.Drawing.Point 270, 140),
            (New-Object System.Drawing.Point 340, 140),
            (New-Object System.Drawing.Point 380, 250),
            (New-Object System.Drawing.Point 350, 370),
            (New-Object System.Drawing.Point 290, 440),
            (New-Object System.Drawing.Point 230, 350),
            (New-Object System.Drawing.Point 230, 240)
        )
        $g.FillClosedCurve($chiliBrush, $pts)

        # Rot spot
        $rotBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(200, 113, 63, 18))
        $g.FillEllipse($rotBrush, 260, 280, 70, 60)
        $rotBrush.Dispose()

        # Fruit Fly (Bactrocera) resting on chili
        $flyBody = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 180, 83, 9))
        $flyThorax = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 67, 20, 7))
        $flyWing = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(170, 224, 242, 254))
        $wingPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(200, 150, 150, 150)), 1

        # Body
        $g.FillEllipse($flyThorax, 310, 190, 26, 26)
        $g.FillEllipse($flyBody, 322, 198, 34, 20)

        # Wings extended
        $g.FillEllipse($flyWing, 300, 175, 45, 18)
        $g.DrawEllipse($wingPen, 300, 175, 45, 18)
        $g.FillEllipse($flyWing, 315, 215, 45, 18)
        $g.DrawEllipse($wingPen, 315, 215, 45, 18)

        # Striped abdomen pattern
        $stripPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(255, 254, 240, 138)), 2
        $g.DrawLine($stripPen, 332, 203, 332, 213)
        $g.DrawLine($stripPen, 342, 202, 342, 214)

        $chiliBrush.Dispose(); $flyBody.Dispose(); $flyThorax.Dispose(); $flyWing.Dispose(); $wingPen.Dispose(); $stripPen.Dispose()
    }

    # Bottom Title Tag on Card Image
    $tagBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(220, 15, 23, 42))
    $g.FillRectangle($tagBrush, 0, 480, 600, 120)
    $tagBrush.Dispose()

    $fCat = New-Object System.Drawing.Font 'Arial', 11, ([System.Drawing.FontStyle]::Bold)
    $fTitle = New-Object System.Drawing.Font 'Arial', 17, ([System.Drawing.FontStyle]::Bold)
    $fSub = New-Object System.Drawing.Font 'Arial', 11, ([System.Drawing.FontStyle]::Italic)

    $catBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 253, 224, 71)) # Yellow
    $white = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
    $subBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 203, 213, 225))

    $g.DrawString($categoryText.ToUpper(), $fCat, $catBrush, 24, 495)
    $g.DrawString($title, $fTitle, $white, 24, 520)
    $g.DrawString($subtitle, $fSub, $subBrush, 24, 555)

    $fCat.Dispose(); $fTitle.Dispose(); $fSub.Dispose()
    $catBrush.Dispose(); $white.Dispose(); $subBrush.Dispose()
    $g.Dispose()

    $bmp.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

# 1. Kebun Cabai Banner
Draw-KebunCabai -outputPath 'assets\images\kebun_cabai.png'

# 2. Virus Gemini
Draw-CardIllustration -outputPath 'assets\images\gemini_virus.png' `
    -title 'Virus Gemini (Bule / Kuning)' `
    -subtitle 'Pepper Yellow Leaf Curl Virus (PepYLCV)' `
    -categoryText 'Penyakit • Menyerang Daun' `
    -mainColor ([System.Drawing.Color]::FromArgb(255, 217, 119, 6)) `
    -bgColor ([System.Drawing.Color]::FromArgb(255, 254, 243, 199)) `
    -type 'gemini'

# 3. Antraknosa
Draw-CardIllustration -outputPath 'assets\images\antraknosa.png' `
    -title 'Antraknosa (Patek / Busuk Buah)' `
    -subtitle 'Colletotrichum capsici' `
    -categoryText 'Penyakit • Menyerang Buah' `
    -mainColor ([System.Drawing.Color]::FromArgb(255, 220, 38, 38)) `
    -bgColor ([System.Drawing.Color]::FromArgb(255, 254, 226, 226)) `
    -type 'antraknosa'

# 4. Bercak Daun
Draw-CardIllustration -outputPath 'assets\images\bercak_daun.png' `
    -title 'Bercak Daun (Cercospora)' `
    -subtitle 'Cercospora capsici' `
    -categoryText 'Penyakit • Menyerang Daun' `
    -mainColor ([System.Drawing.Color]::FromArgb(255, 5, 150, 105)) `
    -bgColor ([System.Drawing.Color]::FromArgb(255, 209, 250, 229)) `
    -type 'bercak_daun'

# 5. Kutu Daun
Draw-CardIllustration -outputPath 'assets\images\kutu_daun.png' `
    -title 'Kutu Daun (Aphids)' `
    -subtitle 'Aphis gossypii' `
    -categoryText 'Hama • Menyerang Daun Muda & Pucuk' `
    -mainColor ([System.Drawing.Color]::FromArgb(255, 124, 58, 237)) `
    -bgColor ([System.Drawing.Color]::FromArgb(255, 237, 233, 254)) `
    -type 'kutu_daun'

# 6. Lalat Buah
Draw-CardIllustration -outputPath 'assets\images\lalat_buah.png' `
    -title 'Lalat Buah' `
    -subtitle 'Bactrocera sp.' `
    -categoryText 'Hama • Menyerang Buah Cabai' `
    -mainColor ([System.Drawing.Color]::FromArgb(255, 234, 88, 12)) `
    -bgColor ([System.Drawing.Color]::FromArgb(255, 255, 237, 213)) `
    -type 'lalat_buah'

Write-Host "All 6 images successfully generated!"

