*** Settings ***
Library    Browser
Library    Collections
Library    String

Resource   resources/components/pages.resource
Resource   ./config/endpoints.resource
Resource   ./resources/pages/LoginPage.resource

*** Variables ***
${DEVICE}     desktop
${VELOCITY}   500ms
${TIMEOUT}    5

*** Keywords ***
Open Website
    IF    '${DEVICE}' == 'mobile'
        Open Mobile Context
    ELSE
        Open Desktop Context
    END
    New Page    ${URL}

Open Desktop Context
    New Browser    chromium    headless=${HEADLESS}    slowMo=${VELOCITY}
    New Context

Open Mobile Context
    New Browser    chromium    headless=${HEADLESS}    slowMo=${VELOCITY}
    New Context
    ...    viewport={'width': 520, 'height': 914}
    ...    isMobile=${True}
    ...    hasTouch=${True}

Ensure Logged In And Home
    LoginPage.Login
    Validate Home Screen