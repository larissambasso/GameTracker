*** Settings ***
Library    RequestsLibrary
Library    BuiltIn
Library    Collections

Resource   ../variables/api.resource
Resource   ../variables/users.resource
Resource   ../settings.resource

*** Keywords ***


Login Supabase via API
    Create Session    auth    ${SUPABASE_AUTH_BASE}    timeout=${TIMEOUT}

    &{headers}=    Create Dictionary
    ...    apikey=${ANON_KEY}
    ...    Authorization=Bearer ${ANON_KEY}
    ...    Content-Type=application/json

    &{body}=    Create Dictionary
    ...    email=${EMAIL}
    ...    password=${PASSWORD}

    &{params}=    Create Dictionary
    ...    grant_type=password

    ${resp}=    POST On Session    auth    url=/auth/v1/token    params=${params}    json=${body}    headers=${headers}
    Should Be Equal As Integers    ${resp.status_code}    200

    &{data}=    Evaluate    json.loads($resp.text)    json
    ${jwt}=     Get From Dictionary    ${data}    access_token

    # se quiser guardar para outros testes:
    Set Suite Variable    ${JWT_TOKEN}    ${jwt}


Checar Endpoint Protegido
    ${old}=    Set Log Level    NONE

    Create Session    api    ${API_BASE}    timeout=${TIMEOUT}

    &{headers}=    Create Dictionary
    ...    Authorization    Bearer ${JWT_TOKEN}
    ...    Content-Type    application/json

    ${resp}=    GET On Session    api    ${ENDPOINT}    headers=${headers}
    Run Keyword Unless    ${resp.status_code} == 200
    ...    Fail    API check falhou: ${API_BASE}${ENDPOINT} retornou ${resp.status_code}. Body: ${resp.text}

    Set Log Level    ${old}

Suite Setup Seguro
    Login Supabase via API
    Checar Endpoint Protegido

