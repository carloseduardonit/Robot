
*** Settings ***
Resource   linkedin_candidatura.robot


*** Keywords ***
Acesso as vagas
    [Documentation]    Acessa a listagem de vagas da página atual 
    ...    e inicia candidatura nas que ainda não foram aplicadas.  
    [Tags]    Linkedin    OK
     
    ${Pagina}=    Evaluate    ${Pagina} + 1
    Set Global Variable    ${Pagina}
    Log    message=Pagina ${Pagina} acessada

    Wait Until Element Is Visible    locator=${div_vagas}    timeout=30s
    ${Vagas} =    RPA.Browser.Selenium.Get Element Count   ${div_vagas}
    ${numero_vaga} =  Set Variable    0
    WHILE  ${numero_vaga} < ${Vagas}
        ${teste} =     Ja se candidatou a esta vaga?      ${numero_vaga} 
        Scroll E Clica No Elemento   //div[contains(@class,'job-card-container--viewport-tracking-${${Vagas}-1}')]//a
        IF   not ${teste}
            Acessar o cartao da Vaga    ${numero_vaga}  
            Faça a Candidatura da vaga simplificada
        END
        Fechar o cartao da Vaga   ${numero_vaga}
        ${Vagas} =   RPA.Browser.Selenium.Get Element Count     ${div_vagas}
        ${numero_vaga} =  Set Variable    ${${numero_vaga} + 1}
    END

Acessar o cartao da Vaga
     [Documentation]    Acessa o cartão da vaga pelo número de item 
     ...    e realiza captura de tela do cartão e seu conteúdo.
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

Candidatar ao processo extensivo
    [Documentation]    Realiza a candidatura automática em um processo seletivo com etapas progressivas.
    ...                Essa keyword verifica se a barra de progresso da candidatura está visível.
    ...                Caso esteja, inicia o fluxo clicando nos botões de avanço até que o progresso alcance 100%.
    ...                Quando finalizado, clica no botão de envio final e registra capturas de tela do processo.
    ...                Fluxo:
    ...                - Verifica visibilidade da barra de progresso
    ...                - Enquanto progresso < 100, aciona botões de avanço
    ...                - Finaliza a candidatura e captura evidência visual
    [Tags]    Linkedin    OK     DOC_OK

    ${resposta} =  Is Element Visible   ${path_progresso}
    IF  ${resposta}
        ${progresso_valor} =    Obter valor do progresso
        WHILE    ${progresso_valor} < 100
            Manipular Element   ${botao_avancarCandidatura} 
            Manipular Element   ${botao_revisarCandidatura}
            Manipular Element   ${botao_enviarCandidatura}           
            ${progresso_valor} =  Obter valor do progresso
            Sleep    2s
        END 
        Capture Page Screenshot 
        Manipular Element    ${botao_finalizarCandidatura}
    END

Candidatar ao processo simples
    [Documentation]    Realiza a candidatura simples quando não há barra de progresso visível.
    ...                Essa keyword assume que o processo é direto e sem etapas intermediárias.
    ...                Fluxo:
    ...                - Verifica se o elemento de progresso está ausente
    ...                - Clica nos botões de revisão, envio e finalização da candidatura

    [Tags]    Linkedin    OK

    ${resposta} =  Is Element Visible  ${path_progresso}
    IF  not ${resposta}
        Manipular Element   ${botao_revisarCandidatura}
        Manipular Element   ${botao_enviarCandidatura}
        Manipular Element    ${botao_finalizarCandidatura}
    END

Clique na filtragem da Candidatura simplificada
    [Documentation]    Clica no botão de filtro de candidatura simplificada, 
    ...                se visível, e captura a tela com os resultados.
    [Tags]    button    OK
    ${Resposta} =  Is Element Visible   locator=${botao_filtragemVagaSimplificada}
    IF   ${Resposta}
        Wait Until Element Is Visible    locator=${botao_filtragemVagaSimplificada}   timeout=150
        Click Button  ${botao_filtragemVagaSimplificada}
    ELSE
        Log    message=Botão de filtragem para vaga simplificada não encontrado
    END
    Sleep    2s
    Capture Page Screenshot     Vagas de ${job} no modelo de vaga simplificada.png

Faça a Candidatura da vaga simplificada
    [Documentation]    Aplica automaticamente para uma vaga com fluxo simplificado.
    ...                Caso o botão de início de candidatura esteja visível, realiza o fluxo completo:
    ...                - Inicia a candidatura
    ...                - Remove alertas de segurança, se houver
    ...                - Tenta aplicar pelos dois tipos de processo (simples e extensivo)
    [Tags]    Linkedin    OK

    Capture Page Screenshot

    ${resposta}=    Is Element Visible    ${botao_iniciarCandidaturaVagaSimplificada}
    IF    ${resposta}
        Manipular Element    ${botao_iniciarCandidaturaVagaSimplificada}
        Remover aviso de segurança
        Candidatar ao processo simples
        Candidatar ao processo extensivo
    END

Obter valor do progresso
    [Documentation]    Obtém o valor atual da barra de progresso, se visível.
    [Tags]    Validação    OK
    Wait Until Element Is Visible    locator=${path_progresso}   timeout=150
    ${resposta} =  Is Element Visible   ${path_progresso}
    IF  ${resposta}
        ${progresso_valor} =    Get Element Attribute    ${path_progresso}    value
        ${progresso_valor} =    Convert To Number   ${progresso_valor}
        Return From Keyword    ${progresso_valor}
    ELSE
        Return From Keyword    False
    END