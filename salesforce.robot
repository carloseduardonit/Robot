*** Settings ***
Variables     Variaveis.py
Library    SeleniumLibrary
Resource    resources/keywords.robot
Resource    resources/variables.robot

*** Variables ***
${Lembra-me}    //*[@id="rememberUn"]

*** Test Cases ***
Login do usuario no sistema
    Open Browser     ${url}     chrome
    Input Text    username    ${admin}
    Input Password    password    ${senha}
    Click Element   ${Lembra-me}
    Checkbox Should Be Selected   ${Lembra-me}
    Click Button    Login
    Close Browser
    
    