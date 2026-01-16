*** Settings ***
Resource    ../../resources/pages.resource
Resource    ../../resources/realizarlogin.resource
Resource    ../../settings.resource

Test Tags    smoke

Test Setup    Open Website


*** Test Cases ***
Home - smoke
    Invalid Login
    Reload
    Wait For Elements State    css=input[placeholder="seu@email.com"]    visible    10s
    Login
    Validate Home Screen


