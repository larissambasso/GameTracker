*** Settings ***
Library    Browser
Library    Collections
Library    String

Resource    ../../variables/ui.resource
Resource    ../../resources/abrirURL.resource
Resource    ../../resources/home.resource
Resource    ../../resources/realizarlogin.resource


*** Test Cases ***

Add-save-complete a game
    Open Website
    Login
    Saved game page
    Wait For Elements State    svg[data-testid="SportsEsportsIcon"] >> nth=0    visible    10s
    Click                      svg[data-testid="SportsEsportsIcon"] >> nth=0
    Wait For Elements State    text="Jogo movido para Jogando!"    attached    500ms
    Click page Jogando
    Wait For Elements State    css=svg[data-testid="SportsScoreIcon"] >> nth=0   visible    10s
    Click    css=svg[data-testid="SportsScoreIcon"] >> nth=0
    Wait For Elements State    role=button[name="Salvar"]    state=visible    timeout=10s