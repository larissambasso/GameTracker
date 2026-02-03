# Carrega .env para variáveis de ambiente (PowerShell)
Get-Content .env | ForEach-Object {
  $line = $_.Trim()

  if ($line -eq "" -or $line.StartsWith("#")) { return }

  $parts = $line -split "=", 2
  if ($parts.Count -lt 2) { return }

  $key = $parts[0].Trim()
  $val = $parts[1].Trim()

  # seta env var corretamente
  Set-Item -Path "Env:$key" -Value $val
}

# roda os testes
robot -d results tests
