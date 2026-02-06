*** Settings ***
Resource    ../../settings.resource


Test Setup    Open Website


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
    Log To Console    TOTAL: ${mm}m ${dd}d ${hh}h ${mi}m


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
    Log times and Total
    Log Total Playtime
