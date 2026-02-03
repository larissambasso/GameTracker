*** Settings ***
Resource    ../../settings.resource




Test Setup    Open Website

*** Variables ***
${EMPTY_STATE}    css=[data-testid="empty-state-message"]
${SEARCH}         Cyberpunk 2077
${INVALID_SEARCH}    asdfghjklqwerty12345
${SEARCH_INPUT}   css=input[placeholder*="Pesquise"]
${TRIES}          5
${INVALID_BASE}   asdfghjklqwerty12345

@{NO_RESULTS_MSGS}
...    Game Over! Esse jogo não apareceu por aqui.
...    Procuramos em todos os saves… nada por aqui.
...    Exploramos o mapa inteiro e não achamos esse jogo.


*** Test Cases ***

Verify Tooltip Logout and exit button
    Ensure Logged In And Home
    Wait For Elements State    css=input[placeholder*="Pesquise"]    visible    10s
    Hover    text="Sair"
    Wait For Elements State    text="Sair"    visible    5s
    Click    text="Sair"
    Wait For Elements State    css=input[placeholder="seu@email.com"]    visible    10s
    ${current_url}=    Get Url
    Should Contain     ${current_url}    /login


Search Games
    [Tags]    smoke
    Ensure Logged In And Home
    Wait For Elements State    css=input[placeholder*="Pesquise"]    visible    10s
    Fill Text                 css=input[placeholder*="Pesquise"]    ${SEARCH}
    Press Keys                css=input[placeholder*="Pesquise"]    Enter
    Wait For Elements State    css=img[alt*="Cyberpunk"] >> nth=0    visible    10s
    ${count}=    Get Element Count    css=img[alt*="Cyberpunk"]
    Should Be True    ${count} > 0
    Log To Console    \n[SEARCH] Cards encontrados: ${count}\n

Search Nonexistent Game
    Ensure Logged In And Home
    Wait For Elements State    css=input[placeholder*="Pesquise"]    visible    10s
    Fill Text                 css=input[placeholder*="Pesquise"]    ${INVALID_SEARCH}
    Press Keys                css=input[placeholder*="Pesquise"]    Enter
    Wait For Elements State    css=[data-testid="empty-state-message"]    visible    10s


Randomness Message Game Noexistent
    LoginPage.Login

    @{seen}=    Create List

    FOR    ${i}    IN RANGE    ${TRIES}
        Wait For Elements State    ${SEARCH_INPUT}    visible    10s
        Fill Text                 ${SEARCH_INPUT}    ${INVALID_BASE}-${i}
        Press Keys                ${SEARCH_INPUT}    Enter

        Wait For Elements State    ${EMPTY_STATE}    visible    10s
        ${txt}=    Get Text        ${EMPTY_STATE}
        ${txt}=    Strip String    ${txt}
        ${txt}=    Convert To Lower Case    ${txt}
        ${txt}=    Replace String    ${txt}    …    ...

        ${is_gameover}=    Run Keyword And Return Status    Should Contain    ${txt}    game over
        ${is_procuramos}=  Run Keyword And Return Status    Should Contain    ${txt}    procuramos
        ${is_exploramos}=  Run Keyword And Return Status    Should Contain    ${txt}    exploramos

        Should Be True    ${is_gameover} or ${is_procuramos} or ${is_exploramos}

        IF    ${is_gameover} and 'gameover' not in @{seen}
            Append To List    ${seen}    gameover
        ELSE IF    ${is_procuramos} and 'procuramos' not in @{seen}
            Append To List    ${seen}    procuramos
        ELSE IF    ${is_exploramos} and 'exploramos' not in @{seen}
            Append To List    ${seen}    exploramos
        END

        Press Keys    ${SEARCH_INPUT}    Control+A
        Press Keys    ${SEARCH_INPUT}    Backspace
    END

    ${unique}=    Get Length    ${seen}
    Log To Console    Categorias únicas vistas: ${unique} -> ${seen}
    Should Be True    ${unique} >= 2


Verify save button game
    Ensure Logged In And Home
    Button Save Game

Validate Click Card Game
    Ensure Logged In And Home
    Click Card Game

Validate saved game page
    Ensure Logged In And Home
    Saved game page
