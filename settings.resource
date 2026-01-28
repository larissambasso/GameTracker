*** Settings ***
Library    Browser
Library    Collections
Library    String

Resource    ./resources/realizarlogin.resource
Resource    ./resources/pages.resource
Resource    ./variables/api.resource

*** Keywords ***
Open Website
    New Browser    chromium    headless=${HEADLESS}    slowMo=${VELOCIT}
    New Context
    New Page    ${URL}

Ensure Logged In And Home
    Login
    Validate Home Screen


*** Variables ***
${VELOCIT}    500ms
${TIMEOUT}      5