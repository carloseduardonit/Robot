*** Settings ***
Library     RPA.Browser.Selenium
#Library     Browser
Library     String
Resource    ../linkedin_locator.robot
Resource    ../linkedin_suporte.robot
Resource    linkedin_questoes.robot

*** Variables ***
${botao_continuarCandidatura}    //span[contains(.,'Continuar candidatura')]
${vaga_com_aviso}   //h2[contains(.,'Lembrete de segurança da pesquisa de vagas')]
*** Keywords ***
Remover aviso de segurança
    [Documentation]    Remove o aviso de segurança da vaga, se estiver presente.
    ...                Essa keyword utiliza a verificação da presença de alertas
    ...                e, caso identificada, clica no botão para continuar a candidatura.
    [Tags]    button    OK

    ${resposta} =  Existe algum aviso de segurança?
    IF  ${resposta}
        Manipular Element    ${botao_continuarCandidatura}
    END

Existe algum aviso de segurança?
    [Documentation]    Verifica se há um aviso de segurança visível na vaga.
    ...                Essa keyword retorna um valor booleano (True ou False),
    ...                indicando se o elemento identificado por `${vaga_com_aviso}` está visível na tela.
    [Tags]    Validação    OK

    ${resposta} =  Is Element Visible   ${vaga_com_aviso}
    Return From Keyword    ${resposta}

Ja se candidatou a esta vaga?
    [Documentation]    Verifica se o candidato já se candidatou a uma vaga específica.
    ...                A verificação é feita por dois indicadores:
    ...                - Se há a marcação "Candidatou-se"
    ...                - Se a vaga está oculta com a mensagem "Não exibiremos mais esta vaga a você."
    ...                Retorna `${True}` se qualquer uma das condições for verdadeira, senão `${False}`.
    [Tags]    Validação    OK
    [Arguments]    ${numero_item}

    ${Candidatou} =  Set Variable     //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//li[contains(.,'Candidatou-se')]
    ${resposta} =  Is Element Visible   ${Candidatou}

    ${nao_exibir} =  Set Variable    //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//div[contains(.,'Não exibiremos mais esta vaga a você.')]
    ${resposta1} =  Is Element Visible   ${nao_exibir}

    Return From Keyword If   ${resposta} or ${resposta1}    ${True}
    Return From Keyword     ${False}  