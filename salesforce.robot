*** Settings ***
Documentation    Suite de testes para o Salesforce
Variables     Variaveis.py
Library    SeleniumLibrary
Resource    resources/keywords.robot
Resource    resources/variables.robot

*** Variables ***
${Lembra-me}    //*[@id="rememberUn"]

*** Test Cases ***
Login do usuario no sistema
    [Documentation]    Teste de login no sistema
    [Tags]    login_Administrador 
    Open Browser     ${url}     chrome
    Input Text    username    ${admin}
    Input Password    password    ${senha}
    Click Element   ${Lembra-me}
    Checkbox Should Be Selected   ${Lembra-me}
    Click Button    Login
    Close Browser
    
    