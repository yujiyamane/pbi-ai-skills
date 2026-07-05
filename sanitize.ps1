$source = "."
$dest = "clean"

if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
robocopy $source $dest /E /XD .git output screenshots clean __pycache__ .pytest_cache /XF *.pyc

$files = Get-ChildItem $dest -Recurse -Include *.md,*.py,*.json,*.ps1,*.txt
foreach ($f in $files) {
    $content = Get-Content $f -Raw
    $content = $content -replace 'NSW Health','NSV Stealth'
    $content = $content -replace 'eHealth','eStealth'
    $content = $content -replace '\bNSW\b','NSV'
    $content = $content -replace '\bDAS\b','BAS'
    $content = $content -replace '\d{4}[\s-]\d{4,}','555-555-5555'
    Set-Content $f $content
}

$template = "$dest\pbi-user-guide-drafter\assets\template.docx"
if (Test-Path $template) { Remove-Item $template }

Write-Host "Sanitised output in: $dest"
