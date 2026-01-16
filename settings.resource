*** Settings ***
Library    Browser
Library    Collections
Library    String

Resource    ./resources/realizarlogin.resource
Resource    ./resources/pages.resource

*** Keywords ***
Open Website
    New Browser    chromium    headless=${HEADLESS}    slowMo=${VELOCIT}
    New Context
    New Page    ${URL}

Ensure Logged In And Home
    Login
    Validate Home Screen


*** Variables ***
${URL}        http://192.168.0.21:5173/login
${VELOCIT}    500ms
${HEADLESS}   False