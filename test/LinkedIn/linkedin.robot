*** Settings ***
Resource    ../../resources/keywords.robot
Resource    ../../resources/variables.robot
Variables    linkedin.py
Library    SeleniumLibrary
Test Setup    Open Linkedin    
Test Teardown    Close Linkedin

*** Variables ***
${campoSeach}    //input[contains(@class,'basic-input jobs-search-box__text-input jobs-search-box__keyboard-text-input jobs-search-global-typeahead__input')]
${h3.nome}      //h3[contains(.,'${name}')]
${h2.title}    //h2[contains(.,'Vagas selecionadas para você')]
#  Botao
${botao.simplificado}    //button[@aria-label='Filtro Candidatura simplificada.']
${botao.homeOffice}    //button[contains(@id,'workplaceType')]
${combo.homeOffice}    (//input[contains(@name,'remoto-filter-value')])[1]

    
*** Keywords ***
Linkedin Job Search
    [Documentation]    Search for a job on Linkedin
    [Tags]    Linkedin
    Wait Until Element Is Visible    locator=${h3.nome}    timeout=150
    Go To    ${urlJob}
    Sleep  15
    Element Should Be Visible    ${h2.title}
    Input Text    ${campoSeach}   ${job}
    Press Keys    ${campoSeach}    ENTER
    Sleep    15
    Capture Page Screenshot

Clique na Candidatura simplificada
    [Documentation]    Click on the simplified application button
    [Tags]    button
    Wait Until Element Is Visible    locator=${botao.simplificado}    timeout=15
    Click Button  ${botao.simplificado}
    Capture Page Screenshot

Clique na vaga Home Office
    [Documentation]   Clique na vaga Home Office
    [Tags]    button
    Wait Until Element Is Visible    locator=${botao.homeOffice}    timeout=15
    Click Button  ${botao.homeOffice}
#    Click Element    locator=${combo.homeOffice}
#   Select Checkbox    locator=${combo.homeOffice}
    Sleep    150
    Capture Page Screenshot

*** Test Cases ***

Vagas home office simplificado
    [Documentation]   Pesquisar vagas de QA no Linkedin Home Office modo simplificado
    [Tags]    Linkedin
    Linkedin Job Search
#    Clique na Candidatura simplificada
    Clique na vaga Home Office