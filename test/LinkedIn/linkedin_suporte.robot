*** Settings ***
Library    RPA.Browser.Selenium
*** Variables ***
${job}      Analista de qualidade 
*** Keywords ***
Manipular Element
    [Documentation]    Manipular o elemento
    [Tags]    Manipular
    [Arguments]   ${elemento}
    Run Keyword And Ignore Error    Click Element If Visible  ${elemento}    
