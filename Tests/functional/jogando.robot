*** Settings ***
Resource    ../../settings.resource

Resource    ../../resources/pages.resource
Resource    ../../resources/pages/LoginPage.resource

Test Setup    Open Website


*** Keywords ***
Set Hours And Minutes
    [Arguments]    ${h}    ${m}
    Fill Text    css=input[name="hours_played.hours"]      ${h}
    Fill Text    css=input[name="hours_played.minutes"]    ${m}

Select conclusion date
    Click       css=input[name="completed_at"]
    Fill Text   css=input[name="completed_at"]    2026-01-19
    ${val}=     Get Property    css=input[name="completed_at"]    value
    Should Be Equal    ${val}    2026-01-19

Select Rating
    [Arguments]    ${value}
    Click    css=div:has(> label:has-text("Sua Avaliação")) label:has(+ input[type="radio"][value="${value}"])
    Wait For Elements State
    ...    css=span.text-2xl.font-black.text-yellow-500.w-10.text-right:has-text("7")
    ...    visible
    ...    5s



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

Check not saved info
    Ensure Logged In And Home
    Click page Jogando
    Wait For Elements State    css=svg[data-testid="SportsScoreIcon"] >> nth=0   visible    10s
    Click    css=svg[data-testid="SportsScoreIcon"] >> nth=0
    Wait For Elements State    role=button[name="Salvar"]    state=visible    timeout=10s
    Click    role=button[name="Salvar"]
    Wait For Elements State    text="A plataforma usada e obrigatoria"    visible    10s

Validate close modal stats
    Ensure Logged In And Home
    Click page Jogando
    Wait For Elements State    css=svg[data-testid="SportsScoreIcon"] >> nth=0   visible    10s
    Click    css=svg[data-testid="SportsScoreIcon"] >> nth=0
    Wait For Elements State    role=button[name="Salvar"]    state=visible    timeout=10s
    Click    css=[data-testid="CloseIcon"]
    Wait For Elements State    css=svg[data-testid="SportsScoreIcon"] >> nth=0    visible    10s



Verify saved info
    Ensure Logged In And Home
    Click page Jogando
    Wait For Elements State    css=svg[data-testid="SportsScoreIcon"] >> nth=0   visible    10s
    Click    css=svg[data-testid="SportsScoreIcon"] >> nth=0
    Wait For Elements State    role=button[name="Salvar"]    state=visible    timeout=10s
    Set Hours And Minutes    9    47
    Click    css=select[name="platform_used"]
    Select Options By    css=select[name="platform_used"]    label    PlayStation 2
    Click    css=select[name="completion_type"]
    Select Options By    css=select[name="completion_type"]    label    Campanha Principal
    Select conclusion date
    Select Rating    4





