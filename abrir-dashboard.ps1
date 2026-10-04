$ErrorActionPreference = 'Stop'

$root = $PSScriptRoot
$excel = Join-Path $root 'Chapulin PRESUPUESTO JAC2026.xlsm'
$project = Join-Path $root 'Dashboard de resultados.pbip'
$tables = @(
    (Join-Path $root 'Dashboard de resultados.SemanticModel\definition\tables\Gastos.tmdl'),
    (Join-Path $root 'Dashboard de resultados.SemanticModel\definition\tables\CEA.tmdl')
)

if (-not (Test-Path -LiteralPath $excel)) { throw "No se encontro el Excel: $excel" }
if (-not (Test-Path -LiteralPath $project)) { throw "No se encontro el proyecto: $project" }
if (Get-Process -Name PBIDesktop -ErrorAction SilentlyContinue) {
    throw 'Cierra Power BI Desktop antes de abrir este proyecto con el iniciador.'
}

$pattern = 'File\.Contents\("[^"]*Chapulin PRESUPUESTO JAC2026\.xlsm"\)'
$replacement = 'File.Contents("' + $excel + '")'

foreach ($table in $tables) {
    if (-not (Test-Path -LiteralPath $table)) { throw "No se encontro la tabla: $table" }
    $bytes = [System.IO.File]::ReadAllBytes($table)
    $hasBom = $bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF
    $encoding = New-Object System.Text.UTF8Encoding($hasBom)
    $content = [System.IO.File]::ReadAllText($table, $encoding)
    $matches = [regex]::Matches($content, $pattern)
    if ($matches.Count -ne 1) { throw "Se esperaba una ruta de Excel en $table; se encontraron $($matches.Count)." }
    if ($matches[0].Value -ne $replacement) {
        $updated = $content.Substring(0, $matches[0].Index) + $replacement + $content.Substring($matches[0].Index + $matches[0].Length)
        [System.IO.File]::WriteAllText($table, $updated, $encoding)
    }
}

Write-Host "Origen configurado: $excel"
Start-Process -FilePath $project
