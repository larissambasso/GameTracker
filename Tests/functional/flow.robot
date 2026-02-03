*** Settings ***
Resource    ../../settings.resource


Test Setup    Open Website


*** Test Cases ***

Add-save-complete a game
    Ensure Logged In And Home
    Saved game page
    Wait For Elements State    svg[data-testid="SportsEsportsIcon"] >> nth=0    visible    10s
    Click                      svg[data-testid="SportsEsportsIcon"] >> nth=0
    Wait For Elements State    text="Jogo movido para Jogando!"    attached    500ms
    Click page Jogando
    Wait For Elements State    css=svg[data-testid="SportsScoreIcon"] >> nth=0   visible    10s
    Click    css=svg[data-testid="SportsScoreIcon"] >> nth=0
    Wait For Elements State    role=button[name="Salvar"]    state=visible    timeout=10s