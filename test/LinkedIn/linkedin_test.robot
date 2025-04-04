*** Settings ***
Resource    ../../resources/keywords_linkedin.robot
Resource    ../../resources/variables.robot
Variables    linkedin.py
Resource   linkedin_locator.robot
Library    OperatingSystem
Test Setup    Open Linkedin    
# Test Teardown    Close Linkedin

*** Variables ***



${botao.homeOffice}    //button[contains(@id,'workplaceType')]
${combo.homeOffice}    (//input[contains(@name,'remoto-filter-value')])[1]
${botao}  //form//footer//button
# 
${progresso}   //progress
${div_vagas}    //div[contains(@class,'job-card-container--viewport-tracking-')]
# link
${link_Visulizar}     //a[contains(@class,'jobs-s-apply__application-link display-flex align-items-center ember-view')]
# variaveis 
${progresso_valor}  0
${contador}  -1
${test}
${item}  

*** Keywords ***
Clique na filtragem da Candidatura simplificada
    [Documentation]    Click on the simplified application button
    [Tags]    button
    Wait Until Element Is Visible    locator=${botao.simplificado}    timeout=150
    Click Button  ${botao.simplificado}
    Capture Page Screenshot     Vagas de ${job}.png

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
    Click Element If Visible  ${botao_vagaSimplificada}
    Capture Page Screenshot
    ${resposta} =  Is Element Visible     ${link_Visulizar} 
    IF    ${resposta}
        Log    message = "Vaga esta com candidatura realizada"
        
    END

    IF  True
        Log    message= ""
    END

    ${resposta} =  Is Element Visible   ${progresso}
    IF  ${resposta}
        Wait Until Element Is Visible    locator=${progresso}   timeout=15
        ${progresso_valor} =    Get Element Attribute    ${progresso}    value 
        ${progresso_valor} =    Convert To Integer    ${progresso_valor}
        WHILE    ${progresso_valor} < 100
            Manipular Element   ${botao_avancarCandidatura}  
            Manipular Element   ${botao_revisarCandidatura}
            Manipular Element   ${botao_enviarCandidatura}
            ${progresso_valor} =  Get Element Attribute    ${progresso}    value
            ${progresso_valor} =  Convert To Integer    ${progresso_valor}
            Sleep    15
        END 
        Manipular Element    ${botao_finalizarCandidatura}
    END


Quantos elementos 
    [Arguments]    ${elemento}
    RETURN   Get Element Count    ${elemento}

*** Test Cases ***

Vagas home office simplificado
    [Documentation]   Pesquisar vagas de QA no Linkedin Home Office modo simplificado
    [Tags]    Linkedin

    Pesquisar para emprego no Linkedin
    Clique na filtragem da Candidatura simplificada
    Faça a Candidatura da vaga simplificada

#    Clique na filtragem do modelo Home Office
Acessar o cartões de Vagas
    [Documentation]    Acessar o cartão da Vaga
    [Tags]   cartaosVagas
    ${contador}      Set Variable      0
    Pesquisar para emprego no Linkedin
    Clique na filtragem da Candidatura simplificada
    ${Vagas} =    Get Element Count   ${div_vagas}
    WHILE  ${contador} < ${Vagas}
        Acessar o cartão da Vaga    ${contador}
        ${Resposta} =  Is Element Visible   //li[@class='job-card-container__footer-item job-card-container__footer-job-state t-bold'][contains(.,'Candidatou-se')][${contador}]
        IF  ${Resposta} == False
            Faça a Candidatura da vaga simplificada
        ELSE
            Log    message= "Candidatura já realizada" INFO
            Sleep    15
        END
        Fechar o cartão da Vaga   ${contador}
        ${Vagas} =   Get Element Count     ${div_vagas}
        ${contador} =  Evaluate    ${contador} + 1
    END

