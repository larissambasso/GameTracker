*** Settings ***
Resource    ../../settings.resource
Resource    ../../variables/ui.resource
Resource    ../../resources/pages.resource
Resource    ../../resources/realizarlogin.resource

Test Setup    Open Website

*** Test Cases ***

Validate feedback pause game
    Ensure Logged In And Home
    Click page Jogando
    Wait For Elements State    css=svg[data-testid="PauseOutlinedIcon"] >> nth=0   visible    10s
    Click    css=svg[data-testid="PauseOutlinedIcon"] >> nth=0
    Wait For Elements State    text="Mover para Jogarei?"    state=visible    timeout=10s
    Click    role=button[name="Confirmar"]

Validate modal stats
    Ensure Logged In And Home
    Click page Jogando
    Wait For Elements State    css=svg[data-testid="SportsScoreIcon"] >> nth=0   visible    10s
    Click    css=svg[data-testid="SportsScoreIcon"] >> nth=0
    Wait For Elements State    role=button[name="Salvar"]    state=visible    timeout=10s