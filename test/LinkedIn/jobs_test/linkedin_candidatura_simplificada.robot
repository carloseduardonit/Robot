
*** Settings ***
Resource   linkedin_candidatura.robot


*** Keywords ***
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

