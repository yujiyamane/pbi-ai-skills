<#
Generates assets/architecture.svg — the skill-pack pipeline diagram.
Same token + outlined-text rules as build-assets.ps1 (see design/README.md).
#>
param(
    [string]$FontsDir = ($env:HK_FONTS_DIR ?? (Join-Path $PSScriptRoot 'fonts')),
    [string]$OutPath = (Join-Path $PSScriptRoot '..\assets\architecture.svg')
)
$ErrorActionPreference = 'Stop'
Import-Module (Join-Path $PSScriptRoot 'HokusaiAssets.psm1') -Force

$t = Get-HkTokens -Path (Join-Path $PSScriptRoot 'hokusai-theme.css')
$fSans = Join-Path $FontsDir 'ZenKakuGothicNew-Medium.ttf'
$fMono = Join-Path $FontsDir 'IBMPlexMono-Medium.ttf'

$W = 1280; $H = 300
$sb = [System.Text.StringBuilder]::new()
[void]$sb.Append("<svg xmlns=`"http://www.w3.org/2000/svg`" width=`"$W`" height=`"$H`" viewBox=`"0 0 $W $H`" role=`"img`" aria-label=`"pbi-ai-skills pipeline`">")
[void]$sb.Append("<rect x=`"1`" y=`"1`" width=`"$($W-2)`" height=`"$($H-2)`" rx=`"6`" fill=`"$($t['card'])`" stroke=`"$($t['hair'])`" stroke-width=`"1`"/>")
[void]$sb.Append("<defs><marker id=`"arr`" viewBox=`"0 0 10 10`" refX=`"9`" refY=`"5`" markerWidth=`"7`" markerHeight=`"7`" orient=`"auto-start-reverse`"><path d=`"M 0 0 L 10 5 L 0 10 z`" fill=`"$($t['blue'])`"/></marker></defs>")

function Add-SkillNode([double]$x, [double]$y, [string]$label, [string]$sub, [string]$spine) {
    $w = 250; $h = 84
    [void]$script:sb.Append("<rect x=`"$x`" y=`"$y`" width=`"$w`" height=`"$h`" rx=`"5`" fill=`"$($t['foam'])`" stroke=`"$($t['blue'])`" stroke-width=`"1.2`"/>")
    [void]$script:sb.Append("<rect x=`"$x`" y=`"$y`" width=`"4`" height=`"$h`" fill=`"$spine`"/>")
    [void]$script:sb.Append((ConvertTo-HkOutlinedText -Text $label -Font $script:fSans -Size 19 -X ($x+22) -Y ($y+36) -Fill $t['ink']))
    [void]$script:sb.Append((ConvertTo-HkOutlinedText -Text $sub -Font $script:fMono -Size 12.5 -X ($x+22) -Y ($y+62) -Fill $t['muted']))
}
function Add-Artifact([double]$x, [double]$y, [string]$label) {
    $w = 118; $h = 46
    [void]$script:sb.Append("<rect x=`"$x`" y=`"$y`" width=`"$w`" height=`"$h`" rx=`"5`" fill=`"$($t['blue-pale'])`"/>")
    $tw = Get-HkTextWidth -Text $label -Font $script:fMono -Size 14
    [void]$script:sb.Append((ConvertTo-HkOutlinedText -Text $label -Font $script:fMono -Size 14 -X ($x + ($w - $tw)/2) -Y ($y+29) -Fill $t['blue-deep']))
}
function Add-Arrow([double]$x1, [double]$y1, [double]$x2, [double]$y2) {
    [void]$script:sb.Append("<line x1=`"$x1`" y1=`"$y1`" x2=`"$x2`" y2=`"$y2`" stroke=`"$($t['blue'])`" stroke-width=`"1.6`" marker-end=`"url(#arr)`"/>")
}

$rowY = 60
Add-Artifact 40 ($rowY+19) 'CSV / XLSX'
Add-Arrow 160 ($rowY+42) 196 ($rowY+42)
Add-SkillNode 200 $rowY 'pbi-config-drafter' 'data profiling -> config' $t['cat1']
Add-Arrow 452 ($rowY+42) 488 ($rowY+42)
Add-SkillNode 492 $rowY 'pbi-dashboard-generator' 'TMDL + PBIR factory' $t['cat2']
Add-Arrow 744 ($rowY+42) 780 ($rowY+42)
Add-SkillNode 784 $rowY 'pbix-user-guide-drafter' 'PBIP -> branded DOCX' $t['cat3']
Add-Arrow 1036 ($rowY+42) 1072 ($rowY+42)
Add-Artifact 1076 ($rowY+19) 'DOCX guide'

# artifact captions under generator: PBIP opens in Power BI Desktop
Add-Artifact 555 ($rowY+110) 'PBIP'
Add-Arrow 618 ($rowY+86) 618 ($rowY+108)
[void]$sb.Append((ConvertTo-HkOutlinedText -Text 'opens in Power BI Desktop' -Font $fSans -Size 14 -X 660 -Y ($rowY+139) -Fill $t['muted']))

[void]$sb.Append((ConvertTo-HkOutlinedText -Text '409 TDD tests across the pack' -Font $fMono -Size 13 -X 40 -Y ($H-32) -Fill $t['up']))
[void]$sb.Append('</svg>')
New-Item -ItemType Directory -Force (Split-Path $OutPath) | Out-Null
[System.IO.File]::WriteAllText($OutPath, $sb.ToString(), [System.Text.UTF8Encoding]::new($false))
Write-Host "architecture.svg -> $OutPath"
