*** Settings ***
Resource    ../../resources/keywords.robot
Resource    ../../resources/variables.robot
Variables    linkedin.py
Library    SeleniumLibrary
Test Setup    Open Linkedin    
# Test Teardown    Close Linkedin

*** Variables ***
${campoSeach}    //input[contains(@class,'basic-input jobs-search-box__text-input jobs-search-box__keyboard-text-input jobs-search-global-typeahead__input')]
${h3.nome}      //h3[contains(.,'${name}')]
${h2.title}    //h2[contains(.,'Vagas selecionadas para você')]
#  Botao
${botao.simplificado}    //button[@aria-label='Filtro Candidatura simplificada.']
${botao.vagaSimplificada}   (//span[@class='artdeco-button__text'][contains(.,'Candidatura simplificada')])[1]
${botao.homeOffice}    //button[contains(@id,'workplaceType')]
${combo.homeOffice}    (//input[contains(@name,'remoto-filter-value')])[1]
${botao.avancar}    (//span[@class='artdeco-button__text'][contains(.,'Avançar')])
${botao.revisar}    (//span[@class='artdeco-button__text'][contains(.,Revisar)])
${boto.enviarCandidatura}   (//span[@class='artdeco-button__text'][contains(.,Enviar candidatura)])
${progresso}   //progress
# variaveis 
${progresso.valor}  0
${contador}    - 1
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

Clique na filtragem da Candidatura simplificada
    [Documentation]    Click on the simplified application button
    [Tags]    button
    Wait Until Element Is Visible    locator=${botao.simplificado}    timeout=15
    Click Button  ${botao.simplificado}
    Capture Page Screenshot

Clique na filtragem do modelo Home Office
    [Documentation]   Clique na vaga Home Office
    [Tags]    button
    Wait Until Element Is Visible    locator=${botao.homeOffice}    timeout=15
    Click Button  ${botao.homeOffice}
#    Click Element    locator=${combo.homeOffice}
#   Select Checkbox    locator=${combo.homeOffice}
    Sleep    150
    Capture Page Screenshot

Faça a Candidatura da vaga simplificada
    [Documentation]    aplicar para a vaga simplidicada
    [Tags]    Linkedin
    Wait Until Element Is Visible    locator=${botao.vagaSimplificada}    timeout=15
    Click Element  ${botao.vagaSimplificada}
    Capture Page Screenshot
    ${progresso.valor} =    Get Element Attribute    ${progresso}    value    
    WHILE    ${progresso.valor} < 100
        Manipular Element   ${botao.avancar}  
       # Manipular Element   ${botao.revisar}
       # Manipular Element   ${boto.enviarCandidatura}
        ${progresso.valor} =  Get Element Attribute    ${progresso}    value
        Sleep    15
    END
    
Manipular Element
    [Arguments]   ${elemento}
    ${contador} =  Set Variable    0
    ${contador} =  Get Element Count    ${elemento}
    IF    ${contador} > 0
        Wait Until Element Is Visible    locator=${elemento}    timeout=15
        Capture Element Screenshot    ${elemento}
        Click Element    ${elemento}    
        Capture Page Screenshot
    END
    

*** Test Cases ***

Vagas home office simplificado
    [Documentation]   Pesquisar vagas de QA no Linkedin Home Office modo simplificado
    [Tags]    Linkedin
    Linkedin Job Search
    Clique na filtragem da Candidatura simplificada
    Faça a Candidatura da vaga simplificada
#    Clique na filtragem do modelo Home Office