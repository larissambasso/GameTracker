*** Settings ***
Library    Browser
Library    Collections
Library    String

Resource    ../../variables/ui.resource
Resource    ../../resources/abrirURL.resource
Resource    ../../resources/home.resource
Resource    ../../resources/realizarlogin.resource

*** Test Cases ***

Validate feedback pause game
    Open Website
    Login
    Click page Jogando
    Wait For Elements State    css=svg[data-testid="PauseOutlinedIcon"] >> nth=0   visible    10s
    Click    css=svg[data-testid="PauseOutlinedIcon"] >> nth=0
    Wait For Elements State    text="Mover para Jogarei?"    state=visible    timeout=10s
    Click    role=button[name="Confirmar"]

Validate modal stats
    Open Website
    Login
    Click page Jogando
    Wait For Elements State    css=svg[data-testid="SportsScoreIcon"] >> nth=0   visible    10s
    Click    css=svg[data-testid="SportsScoreIcon"] >> nth=0
    Wait For Elements State    role=button[name="Salvar"]    state=visible    timeout=10s