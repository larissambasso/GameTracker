*** Settings ***
Resource    ../../settings.resource


Test Setup    Open Website


*** Keywords ***
Log each game time
    Wait For Elements State    css=div.hidden.md\\:block tbody > tr.group >> nth=0    visible    10s
    ${count}=    Get Element Count    css=div.hidden.md\\:block tbody > tr.group

    FOR    ${i}    IN RANGE    ${count}
        ${status}    ${time}=    Run Keyword And Ignore Error
        ...    Get Text    css=div.hidden.md\\:block tbody > tr.group >> nth=${i} >> td:nth-child(4) span.font-mono.text-xs.font-semibold

        IF    '${status}' == 'PASS'
            Log To Console    Linha ${i+1}: ${time}
        ELSE
            Log To Console    Linha ${i+1}: (sem tempo nessa linha)
        END
    END

Log Total Playtime

    ${months}=    Get Text    css=span.tabular-nums >> nth=0
    ${days}=      Get Text    css=span.tabular-nums >> nth=1
    ${hours}=     Get Text    css=span.tabular-nums >> nth=2
    ${minutes}=   Get Text    css=span.tabular-nums >> nth=3

    Log To Console    Total: ${days} dias ${hours} horas e ${minutes} minutos




*** Test Cases ***
Log each game time
    Ensure Logged In And Home
    Click    role=link[name="Stats"]
    Log each game time
    Log Total Playtime
