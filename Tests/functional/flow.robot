*** Settings ***
Resource    ../../settings.resource


Test Setup    Open Website


*** Variables ***
${SEARCH}         Cyberpunk 2077


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

Filter combined games
    Ensure Logged In And Home
    Wait For Elements State    css=[data-testid="card-game"] >> nth=0    visible    10s
    Wait For Elements State    css=input[placeholder*="Pesquise"]    visible    10s
    Fill Text                 css=input[placeholder*="Pesquise"]    ${SEARCH}
    Press Keys                css=input[placeholder*="Pesquise"]    Enter
    Wait For Elements State    css=[data-testid="card-game"] >> nth=0    visible    10s
    IF    '${DEVICE}' == 'mobile'
        Click    css=span.relative >> svg >> nth=0
    END
    Click    css=input[name="filter-platforms"] >> nth=0
    Wait For Elements State    role=button[name="Aplicar Filtros"] >> nth=0    enabled    10s
    Click    role=button[name="Aplicar Filtros"] >> nth=0
    Wait For Elements State    css=[data-testid="card-game"] >> nth=0    visible    10s
    Wait For Elements State    role=button[name="Aplicar Filtros"] >> nth=0    disabled    10s
    Click Card Game
    Wait For Elements State    xpath=//h3[normalize-space()="Plataformas"]/following-sibling::div[1]    visible    10s
    Wait For Elements State    xpath=//h3[normalize-space()="Plataformas"]/following-sibling::div[1]//span[contains(@class,"uppercase") and normalize-space()="PS5"]    visible    10s

