*** Settings ***
Resource    ../../settings.resource

Resource    ../../resources/pages.resource
Resource    ../../resources/pages/LoginPage.resource

Test Setup    Open Website


*** Test Cases ***

Validate feedback remove
    Ensure Logged In And Home
    Click page Jogarei
    Wait For Elements State    css=svg[data-testid="BookmarkRemoveIcon"] >> nth=0   visible    10s
    Click    css=svg[data-testid="BookmarkRemoveIcon"] >> nth=0
    Wait For Elements State    text="Atenção: Ação Irreversível"    state=visible    timeout=10s
    Click    role=button[name="Sim, remover"]
    Wait For Elements State    text="Jogo removido da lista."    visible    10s

Validate feedback jogando
    Ensure Logged In And Home
    Click page Jogarei
    Wait For Elements State    svg[data-testid="SportsEsportsIcon"] >> nth=0    visible    10s
    Click                      svg[data-testid="SportsEsportsIcon"] >> nth=0
    Wait For Elements State    text="Jogo movido para Jogando!"    attached    5s

Verify game in playing list
    Ensure Logged In And Home
    Click page Jogarei
    Wait For Elements State    css=svg[data-testid="SportsEsportsIcon"] >> nth=0    visible    10s
    Click                      css=svg[data-testid="SportsEsportsIcon"] >> nth=0
    Wait For Elements State    text="Jogo movido para Jogando!"    attached    5s
    Click page Jogando
    Wait For Elements State    svg[data-testid="PauseOutlinedIcon"] >> nth=0    visible    10s

