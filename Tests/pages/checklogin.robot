*** Settings ***
Resource    ../../resources/abrirURL.resource
Resource    ../../resources/home.resource
Resource    ../../resources/realizarlogin.resource

Test Tags    smoke



*** Test Cases ***
Home - smoke
    Open Website
    Invalid Login
    Reload
    Wait For Elements State    css=input[placeholder="seu@email.com"]    visible    10s
    Login
    Validate Home Screen


