*** Settings ***
Resource    ../../resources/keywords_linkedin.robot
Resource    ../../resources/variables.robot
Variables    linkedin.py
Resource   linkedin_locator.robot

Library    OperatingSystem
Test Setup    Open Linkedin    
Test Teardown    Close Linkedin

*** Variables ***

${botao.homeOffice}    //button[contains(@id,'workplaceType')]
${combo.homeOffice}    (//input[contains(@name,'remoto-filter-value')])[1]
${Li_Candidatou}    //li[contains(.,'Candidatou-se')]
# 
${div_vagas}    //div[contains(@class,'job-card-container--viewport-tracking-')]
# link
${link_Visulizar}     //a[contains(@class,'jobs-s-apply__application-link display-flex align-items-center ember-view')]

*** Keywords ***
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
    Capture Page Screenshot
    ${resposta} =  Is Element Visible     ${botao_iniciarCandidaturaVagaSimplificada}
    IF    '${resposta}' == 'True'
        Manipular Element    ${botao_iniciarCandidaturaVagaSimplificada}
        Canditada ao processo simples
        Canditada ao processo extensivo
    END

Canditada ao processo simples
     ${resposta} =  Is Element Visible  ${path_progresso}
    IF  '${resposta}' == 'False'
        Manipular Element   ${botao_avancarCandidatura}  
        Manipular Element   ${botao_revisarCandidatura}
        Manipular Element   ${botao_enviarCandidatura}
        Manipular Element    ${botao_finalizarCandidatura}
    END
Canditada ao processo extensivo
    ${resposta} =  Is Element Visible   ${path_progresso}
    IF  '${resposta}' == 'True'
        Wait Until Element Is Visible    locator=${path_progresso}   timeout=15
        ${progresso_valor} =    Get Element Attribute    ${path_progresso}    value 
        ${progresso_valor} =    Convert To Number   ${progresso_valor}
        WHILE    ${progresso_valor} < 100
            #IF   ${progresso_valor} <= 66
                Manipular Element   ${botao_avancarCandidatura} 
            #END
            #IF    ${progresso_valor} >= 50
                 Manipular Element   ${botao_revisarCandidatura}
            #END
            #IF    ${progresso_valor} == 100
                 Manipular Element   ${botao_enviarCandidatura}
            #END            
            ${progresso_valor} =  Get Element Attribute    ${path_progresso}    value
            ${progresso_valor} =  Convert To Number   ${progresso_valor}
            Sleep    15
        END 
        Capture Page Screenshot 
        Manipular Element    ${botao_finalizarCandidatura}
    END
Quantos elementos 
    [Arguments]    ${elemento}
    RETURN   Get Element Count    ${elemento}

Vaga desejada
    [Arguments]    ${contador}
    ${item} =   Set Variable     ${Li_Candidatou}[${contador}]
    ${Resposta} =  Is Element Visible    ${item}
    IF    '${Resposta}' == 'False'
        Acessar o cartao da Vaga    ${contador}  
        Faça a Candidatura da vaga simplificada
    END
    # Fechar o cartao da Vaga   ${${contador} + 1}
   

*** Test Cases ***

Vagas home office simplificado
    [Documentation]   Pesquisar vagas de QA no Linkedin Home Office modo simplificado
    [Tags]    Linkedin

    Pesquisar para emprego no Linkedin
    Clique na filtragem da Candidatura simplificada
    Acessar o cartao da Vaga    5
    Faça a Candidatura da vaga simplificada
    Fechar o cartao da Vaga    5
    Sleep   1500

#    Clique na filtragem do modelo Home Office
Acessar o cartoes de Vagas
    [Documentation]    Acessar o cartão da Vaga
    [Tags]   cartaosVagas
    ${contador}      Set Variable      0
    Pesquisar para emprego no Linkedin
    Clique na filtragem da Candidatura simplificada
    Wait Until Element Is Visible    locator=${div_vagas}    timeout=150
    ${Vagas} =    Get Element Count   ${div_vagas}
    WHILE  ${contador} < ${Vagas}
        ${item} =   Set Variable     ${Li_Candidatou}[${contador}]
        
        ${Resposta} =  Is Element Visible    ${item}
        
        IF    '${Resposta}' == 'False'
            Acessar o cartao da Vaga    ${contador}  
            Faça a Candidatura da vaga simplificada
        END
       # Fechar o cartao da Vaga   ${${contador} + 1}
        ${Vagas} =   Get Element Count     ${div_vagas}
        ${contador} =  Set Variable    ${${contador} + 1}
    END

Fazer Networking no linkedin
    [Documentation]   Fazer Networking no linkedin
    [Tags]    Linkedin
    Pesquisar de contato como "Rh"
    ${contador}      Set Variable      1
    #Wait Until Element Is Visible    locator=${div_contatos}    timeout=150
    #${quantidade_contatos} =    Get WebElements    ${div_contatos}
    #Log    message=${quantidade_contatos}
    #Seguir os contatos
    Conectar com os contatos
    #WHILE  ${contador} <= ${quantidade_contatos}
        
      #  ${contador} =  Set Variable    ${${contador} + 1}
       # ${quantidade_contatos} =    Get WebElements    ${div_contatos}
    #END