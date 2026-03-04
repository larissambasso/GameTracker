# Carrega .env para variáveis de ambiente
Get-Content .env | ForEach-Object {
    $line = $_.Trim()

    if ($line -eq "" -or $line.StartsWith("#")) { return }

    $parts = $line -split "=", 2
    if ($parts.Count -lt 2) { return }

    $key = $parts[0].Trim()
    $val = $parts[1].Trim()

    Set-Item -Path "Env:$key" -Value $val
}

# Se o primeiro argumento NÃO começa com "-", ele é o device (mobile)
$DEVICE = "web"   # default

if ($args.Count -gt 0 -and -not $args[0].StartsWith("-")) {

    $DEVICE = $args[0]

    if ($args.Count -gt 1) {
        $ROBOT_ARGS = $args[1..($args.Count - 1)]
    } else {
        $ROBOT_ARGS = @()
    }

} else {
    $ROBOT_ARGS = $args
}

Write-Host "Rodando testes em modo: $DEVICE"

robot `
  -d "results/$DEVICE" `
  -v DEVICE:$DEVICE `
  @ROBOT_ARGS `
  tests