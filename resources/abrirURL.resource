*** Settings ***
Library    Browser
Resource   ../variables/ui.resource

*** Keywords ***
Open Website
    New Browser    chromium    headless=${HEADLESS}    slowMo=${VELOCIT}
    New Context
    New Page    ${URL}
