*** Settings ***
Library    Browser
Resource   ../variables/users.resource

*** Keywords ***

Login
    Wait For Elements State    css=input[placeholder="seu@email.com"]    visible    10s
    Fill Text    css=input[placeholder="seu@email.com"]    ${EMAIL}
    Wait For Elements State    css=input[placeholder="password"]    visible    10s
    Fill Text    css=input[placeholder="password"]    ${PASSWORD}
    Click    role=button[name="Entrar"]

Invalid Login
    Wait For Elements State    css=input[placeholder="seu@email.com"]    visible    10s
    Fill Text                 css=input[placeholder="seu@email.com"]    ${INVALID_EMAIL}
    Wait For Elements State    css=input[placeholder="password"]         visible    10s
    Fill Text                 css=input[placeholder="password"]         ${INVALID_PASSWORD}
    Click    role=button[name="Entrar"]
    Wait For Elements State    text=/Invalid login credentials/i    visible    10s


