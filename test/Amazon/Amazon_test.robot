*** Settings ***
Resource    ../../resources/keywords_amazon.robot
Library    SeleniumLibrary
Test Setup    Open Amazon
# Test Teardown    Close Amazon

*** Test Cases ***
Amazon Test
    Input Text    id=twotabsearchtextbox    laptop
    Click Button    xpath=//input[@value='Go']
    