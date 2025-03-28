*** Settings ***
Resource    ../../resources/keywords_linkedin.robot
Resource    ../../resources/variables.robot
Variables    linkedin.py
Variables    linkedin_locator.py
Library    OperatingSystem
Test Setup    Open Linkedin    
# Test Teardown    Close Linkedin

*** Variables ***
${campoSeach}    //input[contains(@class,'basic-input jobs-search-box__text-input jobs-search-box__keyboard-text-input jobs-search-global-typeahead__input')]
${h3.nome}      //h3[contains(.,'${name}')]
${h2.title}    //h2[contains(.,'Vagas selecionadas para você')]
#  Botao
${botao.simplificado}    //button[@aria-label='Filtro Candidatura simplificada.']
${botao_vagaSimplificada}   //span[@class='artdeco-button__text'][contains(.,'Candidatura simplificada')][1]
${botao.homeOffice}    //button[contains(@id,'workplaceType')]
${combo.homeOffice}    (//input[contains(@name,'remoto-filter-value')])[1]
${botao}  //form//footer//button

${botao_avancar}      //span[@class='artdeco-button__text'][contains(.,'Avançar')]
${botao_revisar}      //span[@class='artdeco-button__text'][contains(.,Revisar)]
${botao_enviarCandidatura}   //span[@class='artdeco-button__text'][contains(.,Enviar candidatura)]
${progresso}   //progress
${div_vagas}    //div[contains(@class,'job-card-container--viewport-tracking-')]
# link
${link_Visulizar}     //a[contains(@class,'jobs-s-apply__application-link display-flex align-items-center ember-view')]
# variaveis 
${progresso_valor}  0
${contador}  =  -1
${test}
${item}

*** Keywords ***
Linkedin Job Search
    [Documentation]    Search for a job on Linkedin
    [Tags]    Linkedin
    Wait Until Element Is Visible   locator=${h3.nome}    timeout=150
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
    Wait Until Element Is Visible    locator=${botao_vagaSimplificada}    timeout=15
    Click Element If Visible  ${botao_vagaSimplificada}
    Capture Page Screenshot
    ${item} =   Is Element Attribute Equal To    ${link_Visulizar}   value    'Visualizar candidatura'
    Wait Until Element Is Visible    locator=${progresso}   timeout=15
    ${progresso_valor} =    Get Element Attribute    ${progresso}    value 
    ${progresso_valor} =    Convert To Integer    ${progresso_valor}
    WHILE    ${progresso_valor} < 100
        Manipular Element   ${botao_avancar}  
        Manipular Element   ${botao_revisar}
        Manipular Element   ${botao_enviarCandidatura}
        ${progresso_valor} =  Get Element Attribute    ${progresso}    value
        ${progresso_valor} =  Convert To Integer    ${progresso_valor}
        Sleep    15
    END
    
Manipular Element
    [Arguments]   ${elemento}
    Run Keyword And Ignore Error    Click Element If Visible  ${elemento}    

Quantos elementos 
    [Arguments]    ${elemento}
    RETURN   Get Element Count    ${elemento}

Acessar o cartão da Vaga
    [Documentation]    Acessar o cartão da Vaga
    [Tags]    cartaosVagas
    [Arguments]    ${numero_item}

    ${item}    Set Variable     //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]
    Capture Element Screenshot    locator=${item} 
        ...   filename=vaga${contador}.png
    Wait Until Element Is Visible    locator=${item}//strong    timeout=15
    log  ${item}//strong
    Click Element    locator=${item}//strong
    Capture Page Screenshot    paginavaga${contador}.png

*** Test Cases ***

Vagas home office simplificado
    [Documentation]   Pesquisar vagas de QA no Linkedin Home Office modo simplificado
    [Tags]    Linkedin
    Linkedin Job Search
    Clique na filtragem da Candidatura simplificada
    Faça a Candidatura da vaga simplificada
#    Clique na filtragem do modelo Home Office
Acessar o cartões de Vagas
    [Documentation]    Acessar o cartão da Vaga
    
    ${contador}      Set Variable      0
    Linkedin Job Search
    Clique na filtragem da Candidatura simplificada
    ${Vagas} =    Get Element Count   ${div_vagas}
    WHILE  ${contador} < ${Vagas}
        Acessar o cartão da Vaga    ${contador}
        Faça a Candidatura da vaga simplificada
        ${Vagas} =   Get Element Count     ${div_vagas}
        ${contador}  Set Variable  ${${contador} + 1}
    END

