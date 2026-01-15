*** Settings ***
Library    Browser

*** Keywords ***
Validate Home Screen
    Wait For Elements State    role=link[name="Jogarei"]    visible    5s

Button Save Game
    Wait For Elements State    css=[data-testid="BookmarkIcon"] >> nth=0    visible    10s
    Click    css=[data-testid="BookmarkIcon"] >> nth=0
    Wait For Elements State    css=[data-testid="BookmarkBorderIcon"] >> nth=0    visible    10s

Click Card Game
    Wait For Elements State    css=[data-testid="card-game"] >> nth=0    visible    10s
    Click                      css=[data-testid="card-game"] >> nth=0
    ${url}=    Get Url
    Should Contain    ${url}    /search?game=
    Click                      css=[data-testid="CloseIcon"]

Click page Jogarei
    Wait For Elements State    role=link[name="Jogarei"]    visible    10s
    Click                      role=link[name="Jogarei"]

Click page Jogando
    Wait For Elements State    role=link[name="Jogando"]    visible    10s
    Click                      role=link[name="Jogando"]

Saved game page
    Wait For Elements State    css=svg[data-testid="BookmarkBorderIcon"] >> nth=0    visible    10s
    ${btn}=    Set Variable    css=svg[data-testid="BookmarkBorderIcon"] >> nth=0 >> xpath=ancestor::button[1]
    ${card}=    Set Variable    ${btn} >> xpath=ancestor::div[contains(@class,"relative")][1]
    ${game_name}=    Get Text    ${card} >> css=span >> nth=0
    ${game_name}=    Strip String    ${game_name}
    Click    css=[data-testid="BookmarkBorderIcon"] >> nth=0
    Log To Console    Nome do jogo clicado: ${game_name}
    Click    role=link[name="Jogarei"] >> nth=0
    Wait For Elements State    text=${game_name}    visible    10s