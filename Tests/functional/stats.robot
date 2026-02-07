*** Settings ***
Library    String
Resource    ../../settings.resource


Test Setup    Open Website

*** Variables ***
${ZERADOS_COUNTER}    xpath=//span[normalize-space(.)="Zerados"]/ancestor::div[1]/following-sibling::span[1]
${EMPTY_STATE}        data-testid=empty-state-message


*** Keywords ***
Log times and Total
    Wait For Elements State    css=div.hidden.md\\:block tbody > tr.group >> nth=0    visible    10s
    ${count}=    Get Element Count    css=div.hidden.md\\:block tbody > tr.group
    ${total}=    Set Variable    0

    FOR    ${i}    IN RANGE    ${count}
        ${st}    ${t}=    Run Keyword And Ignore Error
        ...    Get Text    css=div.hidden.md\\:block tbody > tr.group >> nth=${i} >> td:nth-child(4) span.font-mono.text-xs.font-semibold

        IF    '${st}' == 'PASS'
            ${t}=    Strip String    ${t}
            Log To Console    Linha ${i+1}: ${t}
            ${h}=    Evaluate    (__import__("re").search(r"(\\d+)h", """${t}""").group(1) if __import__("re").search(r"(\\d+)h", """${t}""") else "0")
            ${m}=    Evaluate    (__import__("re").search(r"(\\d+)m", """${t}""").group(1) if __import__("re").search(r"(\\d+)m", """${t}""") else "0")
            ${total}=    Evaluate    int(${total}) + int(${h})*60 + int(${m})
        ELSE
            Log To Console    Linha ${i+1}: (sem tempo)
        END
    END

    ${mm}=    Evaluate    int(${total}) // (30*24*60)
    ${r}=     Evaluate    int(${total}) % (30*24*60)
    ${dd}=    Evaluate    int(${r}) // (24*60)
    ${r}=     Evaluate    int(${r}) % (24*60)
    ${hh}=    Evaluate    int(${r}) // 60
    ${mi}=    Evaluate    int(${r}) % 60

    ${dd2}=    Format String    {:02d}    ${dd}
    ${hh2}=    Format String    {:02d}    ${hh}
    ${mi2}=    Format String    {:02d}    ${mi}
    Log To Console    Total: ${dd2} dias ${hh2} horas e ${mi2} minutos
    ${total_txt}=    Set Variable    Total: ${dd2} dias ${hh2} horas e ${mi2} minutos


    ${months}=    Get Text    css=span.tabular-nums >> nth=0
    ${days}=      Get Text    css=span.tabular-nums >> nth=1
    ${hours}=     Get Text    css=span.tabular-nums >> nth=2
    ${minutes}=   Get Text    css=span.tabular-nums >> nth=3

    Log To Console    Total: ${days} dias ${hours} horas e ${minutes} minutos
    ${total_games}=    Set Variable    Total: ${days} dias ${hours} horas e ${minutes} minutos
    Should Be Equal    ${total_txt}    ${total_games}


Zerados Counter Should Be
    [Arguments]    ${expected}
    ${after_txt}=    Get Text    ${ZERADOS_COUNTER}
    ${after}=        Convert To Integer    ${after_txt}
    Should Be Equal As Integers    ${after}    ${expected}
    


*** Test Cases ***
Log each game time
    Ensure Logged In And Home
    Click page Stats
    Log times and Total
    Log To Console     Soma das horas OK

Validate edit game
    Ensure Logged In And Home
    Click page Stats
    Wait For Elements State    role=button[name="Editar"] >> nth=0    visible    10s
    Click    role=button[name="Editar"] >> nth=0
    Wait For Elements State    role=button[name="Salvar"]    state=visible    timeout=10s

Validate delete game
    Ensure Logged In And Home
    Click page Stats

    ${has_counter}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${ZERADOS_COUNTER}    state=visible    timeout=2s
    
    IF    ${has_counter}
        ${zerados}=    Get Text    ${ZERADOS_COUNTER}
        ${before}=     Convert To Integer    ${zerados}
        Log To Console    Quantidade de Jogos Zerados (antes)=${before}
        IF    ${before} > 0
            ${expected}=    Evaluate    ${before} - 1

            Wait For Elements State    role=button[name="Excluir"] >> nth=0    visible    10s
            Click    role=button[name="Excluir"] >> nth=0
            Wait For Elements State    text="Atenção: Ação Irreversível"    state=visible    timeout=10s
            Click    role=button[name="Sim, excluir"]

            IF    ${expected} == 0
                Wait For Elements State    ${EMPTY_STATE}    visible    10s
                Log To Console    Quantidade de Jogos Zerados (depois)=0
            ELSE
                Wait Until Keyword Succeeds    10s    500ms    Zerados Counter Should Be    ${expected}
                Log To Console    Quantidade de Jogos Zerados (depois)=${expected}
            END
        ELSE
            Wait For Elements State    ${EMPTY_STATE}    visible    10s
        END
    ELSE
        Wait For Elements State    ${EMPTY_STATE}    visible    10s
    END


