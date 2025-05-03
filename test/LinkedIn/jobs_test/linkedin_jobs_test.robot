*** Settings ***
Library     RPA.Browser.Selenium
Resource    ../linkedin_locator.robot
Resource    ../linkedin_suporte.robot
*** Variables ***
${Li_Candidatou}    //li[contains(.,'Candidatou-se')]
${div_vagas}    //div[contains(@class,'job-card-container--viewport-tracking-')]

*** Keywords ***
Acessar o cartao da Vaga
    [Documentation]    Acessar o cartão da Vaga
    [Tags]    cartaosVagas
    [Arguments]    ${numero_item}

    ${item}    Set Variable     //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//a
    Wait Until Element Is Visible    locator=${item}    timeout= 30
    Capture Element Screenshot    locator=${item}     filename=vaga-${numero_item}.png
    Log    message= ${item}     
    Click Element If Visible    ${item}
    #Manipular Element   locator=${item}
    Capture Page Screenshot    paginavaga-${numero_item}.png
Acesso as "${Paginas}" paginas dos cartoes de vagas e as vagas
    Set Local Variable    ${pagina}     1
    WHILE    ${pagina} <= ${Paginas}
        Acesso as vagas
        Manipular Element    ${botao_avançarPaginaCartao}
        Sleep    150
        Capture Page Screenshot   pagina $pagina.png
    END
    

Acesso as vagas
    Wait Until Element Is Visible    locator=${div_vagas}    timeout=150
    ${Vagas} =    Get Element Count   ${div_vagas}
    ${numero_vaga} =  Set Variable    0
    WHILE  ${numero_vaga} < ${Vagas}
        ${item} =   Set Variable     ${Li_Candidatou}[${numero_vaga}]
        ${Resposta} =  Is Element Visible    ${item}
        IF    '${Resposta}' == 'False'
            Acessar o cartao da Vaga    ${numero_vaga}  
            Faça a Candidatura da vaga simplificada
        END
       # Fechar o cartao da Vaga   ${${contador} + 1}
        ${Vagas} =   Get Element Count     ${div_vagas}
        ${numero_vaga} =  Set Variable    ${${numero_vaga} + 1}
    END
Canditada ao processo extensivo
    ${resposta} =  Is Element Visible   ${path_progresso}
    IF  '${resposta}' == 'True'
        Wait Until Element Is Visible    locator=${path_progresso}   timeout=15
        ${progresso_valor} =    Get Element Attribute    ${path_progresso}    value 
        ${progresso_valor} =    Convert To Number   ${progresso_valor}
        WHILE    ${progresso_valor} < 100
                Manipular Element   ${botao_avancarCandidatura} 
                Manipular Element   ${botao_revisarCandidatura}
                Manipular Element   ${botao_enviarCandidatura}           
            ${progresso_valor} =  Get Element Attribute    ${path_progresso}    value
            ${progresso_valor} =  Convert To Number   ${progresso_valor}
            Sleep    15
        END 
        Capture Page Screenshot 
        Manipular Element    ${botao_finalizarCandidatura}
    END
## Fechar o navegador
Canditada ao processo simples
     ${resposta} =  Is Element Visible  ${path_progresso}
    IF  '${resposta}' == 'False' 
        Manipular Element   ${botao_revisarCandidatura}
        Manipular Element   ${botao_enviarCandidatura}
        Manipular Element    ${botao_finalizarCandidatura}
    END
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

Vaga desejada
    [Arguments]    ${contador}
    ${item} =   Set Variable     ${Li_Candidatou}[${contador}]
    ${Resposta} =  Is Element Visible    ${item}
    IF    '${Resposta}' == 'False'
        Acessar o cartao da Vaga    ${contador}  
        Faça a Candidatura da vaga simplificada
    END
    # Fechar o cartao da Vaga   ${${contador} + 1}