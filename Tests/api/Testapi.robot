*** Settings ***
Resource    ../../resources/validarAPI.resource
Documentation    Validar API antes de rodar as outras suites


Suite Setup  Suite Setup Seguro

*** Test Cases ***
API - endpoint protegido responde 200
    Suite Setup Seguro
