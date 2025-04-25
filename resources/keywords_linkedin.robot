*** Settings ***
Library    RPA.Browser.Selenium
Variables   ../test/Linkedin/linkedin.py
Resource    ../test/LinkedIn/linkedin_locator.robot

*** Variables ***
${job}      Analista de qualidade 
${cidade}      São Paulo, 
${Pais}    Brasil
${Modalidade}    (Remoto)
${span_Local_Vaga}      //span[contains(.,'${cidade} ${Pais} ${Modalidade}')]
${urlJob}    https://www.linkedin.com/jobs/
${urlMinhaRede}    https://www.linkedin.com/mynetwork/grow/
${loginLinkedin}    https://www.linkedin.com/login/pt?fromSignIn=true&trk=guest_homepage-basic_nav-header-signin
*** Keywords ***
## Acessar a home page do site Linkedin.com.br
Open Linkedin
    [Documentation]    Open Linkedin sem parametros
    [Tags]    login
    Open Browser   ${loginLinkedin}     firefox
    ...  options = add_experimental_option("detach", True)
    Maximize Browser Window
    Input Text    ${campo_login}  ${email}
    Input Password    ${campo_senha}    ${senha}
    Click Button    ${botao_submit}
    Sleep    15

Open Linkedin I
    [Documentation]   Open Linkedin  com parametros
    [Arguments]    ${email_usuario}   ${senha_usuario}
    [Tags]     login
    Open Browser   ${loginLinkedin}  firefox
    ...  options = add_experimental_option("detach", True)
    Maximize Browser Window
    Input Text    id=username    ${email_usuario}
    Input Password    id=password    ${senha_usuario}
    Click Button   //button[contains(@type,'submit')]
    Sleep    15
Pesquisar para emprego no Linkedin
    [Documentation]    Pesquisar para emprego no Linkedin
    [Tags]    Pesquisar_emprego
    Wait Until Element Is Visible   locator=${h3_nome}    timeout=150
    Go To    ${urlJob}
    Sleep  15
    Element Should Be Visible    ${h2_title}
    Input Text    ${campoSeach}   ${job}
    Press Keys    ${campoSeach}    ENTER
    Sleep    15
    Capture Page Screenshot    Vagas de ${job}.png
Clique na filtragem da Candidatura simplificada
    [Documentation]    Clique na filtragem da Candidatura simplificada
    [Tags]    button
    Wait Until Element Is Visible    locator=${botao_filtragemVagaSimplificada}   timeout=150s
    Click Button  ${botao_filtragemVagaSimplificada}
    Sleep    15
    Capture Page Screenshot     Vagas de ${job} no modelo de vaga simplificada.png
## Fechar o navegador
Close Linkedin
    [Documentation]    Fechar o navegador do linkedin
    [Tags]     Fechar
    Close Browser

## Keywords para manipular os elementos da tela
Manipular Element
    [Documentation]    Manipular o elemento
    [Tags]    Manipular
    [Arguments]   ${elemento}
    Run Keyword And Ignore Error    Click Element If Visible  ${elemento}    

## Keywords para manipular  card  de  vagas
Acessar o cartao da Vaga
    [Documentation]    Acessar o cartão da Vaga
    [Tags]    cartaosVagas
    [Arguments]    ${numero_item}

    ${item}    Set Variable     //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//strong
    Wait Until Element Is Visible    locator=${item}    timeout= 30
    Capture Element Screenshot    locator=${item}     filename=vaga-${numero_item}.png
    Log    message= ${item}     
    Click Element If Visible    ${item}
    #Manipular Element   locator=${item}
    Capture Page Screenshot    paginavaga-${numero_item}.png
Fechar o cartao da Vaga
    [Documentation]    Fechar o cartão  da Vaga em porcesso de desenvolvimento
    [Tags]    cartaosVagas
    [Arguments]    ${numero_item}

    ${item}    Set Variable    //button[contains(@class,'action-small artdeco-button artdeco-button--muted artdeco-button--2 artdeco-button--tertiary ember-view')][${numero_item}]
    Log        ${item}     INFO
    Wait Until Element Is Visible    locator=${item}    timeout= 30
    Capture Element Screenshot    locator=${item}     filename= fechar-vaga-${numero_item}.png
    Click Element If Visible    ${item}

Pesquisar de contato como "${nome}"
    [Documentation]    Pesquisar de contato como "${nome}"
    [Arguments]    ${numero_item}=0
    [Tags]    contato 
    
    Wait Until Element Is Visible   locator=${h3_nome}   timeout=150
    Go To    url=${urlMinhaRede}
    Sleep  15
    ${campoSeach} =    Set Variable    //input[@data-view-name='search-global-typeahead-input']
    Input Text    ${campoSeach}   ${nome}
    Press Keys    ${campoSeach}    ENTER
    Sleep  15
    Wait Until Element Is Visible    //a[contains(.,'Ver todos os resultados de pessoas')][1]
    Click Element    //a[contains(.,'Ver todos os resultados de pessoas')][1]
    Sleep  30s
    Capture Page Screenshot     Contato de ${nome}.png

Seguir os contatos
    #Wait Until Element Is Visible    ${botao_Seguir}
    [Documentation]    Seguir o contato em porcesso de desenvolvimento
    [Arguments]    ${numero_item}=1
    [Tags]    contato 
    Sleep  15
    ${quantidade_contatos} =   Get Element Count   ${botao_Seguir}
    IF    ${quantidade_contatos} == 0
        Log    message= Não existem contatos para seguir   
        Exit For Loop
        
    END
    FOR    ${contador}    IN RANGE    1    ${quantidade_contatos}
        Seguir o contato    ${contador}
    END
    Seguir o contato

Seguir o contato
    [Documentation]    Seguir o contato em porcesso de desenvolvimento
    [Arguments]    ${numero_item}=1
    [Tags]    contato 
    
    Manipular Element    ${botao_Seguir}[${numero_item}]
    Sleep   15
Conectar com os contatos
    #Wait Until Element Is Visible    ${botao_Conectar}
    [Documentation]    Conectar com o contato em porcesso de desenvolvimento
    [Tags]    contato
    Sleep  15
    ${quantidade_contatos} =   Get Element Count   ${botao_Conectar}
    IF    ${quantidade_contatos} == 0
        Log    message= Não existem contatos para conectar    
        Exit For Loop
        
    END
    FOR    ${contador}    IN RANGE    1    ${quantidade_contatos}
        Conectar ao Cantato    ${contador}
    END

Conectar ao Cantato
    [Documentation]    Concetar ao Contato em porcesso de desenvolvimento
    [Arguments]    ${numero_item}=1
    [Tags]    contato 

    ${item} =     ${botao_Conectar}[${numero_item}]
    Manipular Element    ${item}
    Capture Element Screenshot    ${item}    filename= conectar-contato-${numero_item}.png
    Sleep   15
    Manipular Element   ${botao_EnviarSemNota}
    Sleep  15 
    