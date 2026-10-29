$root = $PSScriptRoot
$enc = New-Object System.Text.UTF8Encoding($false)
$shell = [IO.File]::ReadAllText("$root\shell.html", $enc)
$vp = "$root\parts\video.html"
$video = if (Test-Path $vp) { [IO.File]::ReadAllText($vp, $enc) } else { '<div style="aspect-ratio:16/9;border-radius:20px;border:1px dashed #444;display:grid;place-items:center;color:#888">VIDEO</div>' }
$ch = (1..6 | ForEach-Object { [IO.File]::ReadAllText("$root\parts\ch$_.html", $enc) }) -join "`n"
$out = $shell.Replace('<!--VIDEO-->', $video).Replace('<!--CHAPTERS-->', $ch)
[IO.File]::WriteAllText("$root\index.html", $out, $enc)
"built: $((Get-Item "$root\index.html").Length) bytes"
