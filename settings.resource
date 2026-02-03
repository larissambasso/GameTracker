*** Settings ***
Library    Browser
Library    Collections
Library    String

Resource    resources/components/pages.resource
Resource    ./config/endpoints.resource
Resource    ./resources/pages/LoginPage.resource

*** Keywords ***
Open Website
    New Browser    chromium    headless=${HEADLESS}    slowMo=${VELOCIT}
    New Context
    New Page    ${URL}

Ensure Logged In And Home
    LoginPage.Login
    Validate Home Screen


*** Variables ***
${VELOCIT}    500ms
${TIMEOUT}      5