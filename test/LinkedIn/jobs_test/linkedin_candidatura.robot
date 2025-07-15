*** Settings ***
Documentation
Library     RPA.Browser.Selenium
#Library     Browser
Library     String
Resource    ../linkedin_locator.robot
Resource    ../linkedin_suporte.robot
Resource    linkedin_questoes.robot
Resource    linkedin_jobs_test.robot


*** Variables ***
${botao_continuarCandidatura}    //span[contains(.,'Continuar candidatura')]
${vaga_com_aviso}   //h2[contains(.,'Lembrete de segurança da pesquisa de vagas')]
${Pagina}   0
${Li_Candidatou}    //li[contains(.,'Candidatou-se')]
${div_vagas}    //div[contains(@class,'job-card-container--viewport-tracking-')]
*** Keywords ***
Copiar o link da vaga
    [Documentation]    Copia o atributo href do botão de candidatura padrão da vaga, 
    ...                se estiver visível. 
    ...                Retorna o link se encontrado; 
    ...                retorna None caso o botão não exista.
    [Tags]    link   No_Test

    ${resposta} =  Is Element Visible   ${botao_iniciarCandidaturaVagaPadrao}
    IF    ${resposta}
        ${link}=     Get Element Attribute   ${botao_iniciarCandidaturaVagaPadrao}   href
        Log    message=Link da vaga padrão: ${link}
        Capture Page Screenshot     Vagas de ${job} no modelo de vaga padrão.png
        Return From Keyword    ${link}
    ELSE
        Log    message=Botão de candidatura padrão não encontrado
        Return From Keyword    ${None}
    END
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

Fechar o cartao da Vaga
    [Documentation]    Fecha o cartão da vaga atual, se estiver visível.
    [Tags]    button    OK
    [Arguments]    ${numero_item}
    
    ${fechar_cartao} =  Set Variable  //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//button[contains(@aria-label,'Fechar')]
    ${resposta} =  A "${numero_item}"º vaga está candidatada?
    IF  ${resposta}
        Manipular Element    ${fechar_cartao}
    END

Ja se candidatou a esta vaga?
    [Documentation]    Verifica se o candidato já se candidatou a uma vaga específica.
    ...                A verificação é feita por dois indicadores:
    ...                - Se há a marcação "Candidatou-se"
    ...                - Se a vaga está oculta com a mensagem "Não exibiremos mais esta vaga a você."
    ...                Retorna `${True}` se qualquer uma das condições for verdadeira, senão `${False}`.
    [Tags]    Validação    OK
    [Arguments]    ${numero_item}

    ${resposta} =  A "${numero_item}"º vaga está candidatada?
    ${resposta1} =  A "${numero_item}"º vaga está fechada?

    Return From Keyword If   ${resposta} or ${resposta1}    True
    Return From Keyword     False

Scroll E Clica No Elemento
    [Documentation]    Rola a página até o elemento especificado pelo XPath e clica nele.
    ...                A rolagem é feita para garantir que o elemento esteja visível antes de clicar.
    ...                Se o elemento não for encontrado, a keyword falhará.
    [Arguments]    ${item_xpath}
    [Tags]    Scroll    No_Test
    Execute Javascript
    ...    var el = document.evaluate("${item_xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    if (el) { el.scrollIntoView({block: "center"}); }
    Wait Until Element Is Visible    ${item_xpath}    timeout=10s
    Click Element    ${item_xpath}
