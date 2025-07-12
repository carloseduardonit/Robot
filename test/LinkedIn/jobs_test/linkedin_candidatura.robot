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
    IF  '${resposta}' == 'True'
        Manipular Element    ${botao_continuarCandidatura}
    END

Existe algum aviso de segurança?
    [Documentation]    Verifica se há um aviso de segurança visível na vaga.
    ...                Essa keyword retorna um valor booleano (True ou False),
    ...                indicando se o elemento identificado por `${vaga_com_aviso}` está visível na tela.
    [Tags]    button    OK

    ${resposta} =  Is Element Visible   ${vaga_com_aviso}
    Return From Keyword    ${resposta}

    