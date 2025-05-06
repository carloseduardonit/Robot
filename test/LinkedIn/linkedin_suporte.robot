*** Settings ***
Library    RPA.Browser.Selenium
*** Variables ***
${job}      Analista de qualidade 
*** Keywords ***
Manipular Element
    [Documentation]    Manipular o elemento caso ele esteja visivel, senão ignora o erro
    [Tags]    Manipular    OK
    [Arguments]   ${elemento}
    Run Keyword And Ignore Error    Click Element If Visible  ${elemento}    
