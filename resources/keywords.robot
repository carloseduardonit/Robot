*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open Amazon
    Open Browser    https://www.amazon.com/    chrome  
    ...  options = add_experimental_option("detach", True)
    Maximize Browser Window

Close Amazon
    Close Browser