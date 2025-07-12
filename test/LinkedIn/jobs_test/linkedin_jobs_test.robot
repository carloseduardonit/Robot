*** Settings ***
Library     RPA.Browser.Selenium
#Library     Browser
Library     String
Resource    ../linkedin_locator.robot
Resource    ../linkedin_suporte.robot
Resource    linkedin_candidatura_gupy.robot
Resource    linkedin_candidatura_simplificada.robot
Resource    linkedin_questoes.robot
*** Variables ***
${Pagina}   0
${Li_Candidatou}    //li[contains(.,'Candidatou-se')]
${div_vagas}    //div[contains(@class,'job-card-container--viewport-tracking-')]


${Vaga_Fechada}    //div[@class='job-card-container__footer-item--highlighted display-block t-12 pt1'][contains(.,'Não exibiremos mais esta vaga a você.')]

*** Keywords ***
path do Link do Cartão da Vaga de Numero "${numero_item}"
    [Documentation]    Link do Cartão da Vaga
    [Tags]    Link    No_Test
    RETURN From Keyword  //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//a
Acessar o cartao da Vaga
    [Documentation]    Acessar o cartão da Vaga
    [Tags]    cartaosVagas    OK
    [Arguments]    ${numero_item}

    ${card_vagas}=    Set Variable    //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]
    ${item}=    Set Variable     //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//a
    ${conteudo}=     Set Variable    //div[contains(@class,'job-details--wrapper')]

    # Captura o elemento  como  WebElement
    ${el}=    Get WebElement     ${item}

    Log     ${el}
    # Executa o JavaScript para rolar o elemento para o centro da tela
    Wait Until Page Contains Element  ${el}    timeout=150
    Wait Until Element Is Visible    locator=${item}    timeout= 150
    Capture Element Screenshot    locator=${card_vagas}     filename=O nome da vaga na ${Pagina}º pagina na posição ${numero_item}º das vagas.png  
    Click Element If Visible    ${item}
    Capture Element Screenshot    locator=${conteudo}   filename=O conteudo da vaga na ${Pagina}º pagina na posição ${numero_item}º das vagas.png 

Acesso as "${Paginas}" paginas dos cartoes de vagas e as vagas
    [Documentation]    Acesso as "${Paginas}" paginas dos cartoes de vagas e as vagas
    [Tags]    Linkedin    NOK

    Set Local Variable    ${pagina}     1
    WHILE    ${pagina} <= ${Paginas}
        Acesso as vagas
        Manipular Element    ${botao_avançarPaginaCartao}
        Sleep    150
        Capture Page Screenshot   pagina $pagina.png
    END
    

Acesso as vagas
    [Documentation]    Acesso as vagas    
    [Tags]    Linkedin    OK
    ${auxiliar} =  Set Variable    ${${Pagina} + 1}
    ${Pagina} =  Set Variable    ${auxiliar}
    Log    message=Pagina ${Pagina} acessada
    Wait Until Element Is Visible    locator=${div_vagas}    timeout=150
    ${Vagas} =    RPA.Browser.Selenium.Get Element Count   ${div_vagas}
    ${numero_vaga} =  Set Variable    0
    WHILE  ${numero_vaga} < ${Vagas}
        ${teste} =     Ja se candidatou a esta vaga?      ${numero_vaga} 
        IF   ${teste} == 'False'           
            ${item} =   Set Variable     ${Li_Candidatou}[${numero_vaga}]
            ${Resposta} =  Is Element Visible    ${item}
            IF    '${Resposta}' == 'False'
                Acessar o cartao da Vaga    ${numero_vaga}  
                Faça a Candidatura da vaga simplificada
            END
        END
       # Fechar o cartao da Vaga   ${${contador} + 1}
        ${Vagas} =   RPA.Browser.Selenium.Get Element Count     ${div_vagas}
        ${numero_vaga} =  Set Variable    ${${numero_vaga} + 1}
    END



Copiar o link da vaga
    [Documentation]    Copiar o link da vaga
    [Tags]    link*-  OK

    ${resposta} =  Is Element Visible   ${botao_iniciarCandidaturaVagaPadrao}
    IF  '${resposta}' == 'True'
        ${link}=     Get Element Attribute   ${botao_iniciarCandidaturaVagaPadrao}   href
        Log    message=Link da vaga padrão: ${link}
        Return From Keyword    ${link}
        Capture Page Screenshot     Vagas de ${job} no modelo de vaga padrão.png
    ELSE
        Log    message=Botão de candidatura padrão não encontrado
        Return From Keyword    ${None}
    END
Clique na filtragem da Candidatura simplificada
    [Documentation]    Clique na filtragem da Candidatura simplificada
    [Tags]    button    OK
    ${Auxiliar}=  Is Element Visible   locator=${botao_filtragemVagaSimplificada}
    IF    '${Auxiliar}' == 'True'
        Wait Until Element Is Visible    locator=${botao_filtragemVagaSimplificada}   timeout=150
        Click Button  ${botao_filtragemVagaSimplificada}
    ELSE
        Log    message=Botão de filtragem para vaga simplificada não encontrado
    END
    Sleep    15
    Capture Page Screenshot     Vagas de ${job} no modelo de vaga simplificada.png
Esta canditado a esta vaga?
    [Documentation]    Esta canditado a esta vaga?
    [Tags]    button     OK
    [Arguments]    ${numero_item}

    ${resposta} =  Is Element Visible   ${Li_Candidatou}[${numero_item}]
    Return From Keyword    ${resposta}
Esta vaga está fechada?
    [Documentation]    Esta vaga está fechada
    [Tags]    button
    [Arguments]    ${numero_item}
    ${resposta} =  Is Element Visible   ${Vaga_Fechada}[${numero_item}]
    Return From Keyword    ${resposta}



Faça a Candidatura da vaga simplificada
    [Documentation]    aplicar para a vaga simplidicada
    [Tags]    Linkedin    OK

    Capture Page Screenshot
    ${resposta} =  Is Element Visible     ${botao_iniciarCandidaturaVagaSimplificada}
    IF    '${resposta}' == 'True'
        Manipular Element    ${botao_iniciarCandidaturaVagaSimplificada}
        Remover aviso de segurança
        Candidatar ao processo simples
        Candidatar ao processo extensivo
    END

Vaga desejada
    [Documentation]    Vaga desejada
    [Tags]    ON
    [Arguments]    ${contador}

    ${item} =   Set Variable     ${Li_Candidatou}[${contador}]
    ${Resposta} =  Is Element Visible    ${item}
    IF    '${Resposta}' == 'False'
        Acessar o cartao da Vaga    ${contador}  
        Faça a Candidatura da vaga simplificada
    END
    # Fechar o cartao da Vaga   ${${contador} + 1}
Gerar Link da Gupy
    [Documentation]     Gerar Link da Gupy
    [Tags]    Link    OK
    ${url_gupy} =  Set Variable    gupy.io
    ${resposta}=     Copiar o link da vaga
    ${contem}=   Should Contain    ${resposta}    ${url_gupy}
    IF    '${resposta}' != '${None}' and "${contem}" == "True"
        Log    message=Link da vaga: ${resposta}
        Set Suite Variable    ${link_vaga}    ${resposta}
    ELSE
        Log    message=Link da vaga não encontrado
        Set Suite Variable    ${link_vaga}    ${None}
    END


Ja se candidatou a esta vaga?
    [Documentation]    Ja se candidatou a esta vaga?
    [Tags]    validacao    OK
    [Arguments]    ${numero_item}

    ${Candidatou} =  Set Variable     //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//li[contains(.,'Candidatou-se')]
    ${resposta} =  Is Element Visible   ${Candidatou}
    ${nao_exibir} =  Set Variable    //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//div[contains(.,'Não exibiremos mais esta vaga a você.')]
    ${resposta1} =  Is Element Visible   ${nao_exibir}
    Return From Keyword If   '${resposta}'=='${True}' or '${resposta1}'=='${True}'    '${True}'
    Return From Keyword     '${False}' 