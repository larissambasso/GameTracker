# 1) roda só o global setup
robot -d results .\Tests\api\Testapi.robot
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

# 2) se passou, roda tudo normal
robot -d results\run Tests
exit $LASTEXITCODE
