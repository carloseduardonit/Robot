*** Settings ***
Library    RPA.Browser.Selenium
Variables   ../test/Linkedin/linkedin.py
Resource    ../test/LinkedIn/linkedin_locator.robot

*** Variables ***
${job}     QA
${urlJob}    https://www.linkedin.com/jobs/
${loginLinkedin}    https://www.linkedin.com/login/pt?fromSignIn=true&trk=guest_homepage-basic_nav-header-signin
*** Keywords ***
## Acessar a home page do site Linkedin.com.br
Open Linkedin
    [Documentation]    Open Linkedin sem parametros
    [Tags]    login
    Open Browser   ${loginLinkedin}  firefox
    ...  options = add_experimental_option("detach", True)
    Maximize Browser Window
    Input Text    id=username   ${email}
    Input Password    id=password    ${senha}
    Click Button   //button[contains(@type,'submit')]
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
    Element Should Be Visible    ${h2.title}
    Input Text    ${campoSeach}   ${job}
    Press Keys    ${campoSeach}    ENTER
    Sleep    15
    Capture Page Screenshot    Vagas de ${job}.png
Clique na filtragem da Candidatura simplificada
    [Documentation]    Clique na filtragem da Candidatura simplificada
    [Tags]    button
    Wait Until Element Is Visible    locator=${botao.filtragemVagaSimplificada}   timeout=15
    Click Button  ${botao.filtragemVagaSimplificada}
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
Acessar o cartão da Vaga
    [Documentation]    Acessar o cartão da Vaga
    [Tags]    cartaosVagas
    [Arguments]    ${numero_item}

    ${item}    Set Variable     //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]
    Capture Element Screenshot    locator=${item}     filename= vaga-${numero_item}.png
    Wait Until Element Is Visible    locator=${item}//strong    timeout=150
    Manipular Element   locator=${item}//strong
    Capture Page Screenshot    paginavaga-${numero_item}.png

Fechar o cartão da Vaga
    [Documentation]    Fechar o cartão  da Vaga
    [Tags]    cartaosVagas
    [Arguments]    ${numero_item}

    ${item}     Set Variable    //button[contains(@class,'action-small artdeco-button artdeco-button--muted artdeco-button--2 artdeco-button--tertiary ember-view')]
    Click Element If Visible    ${item}[${numero_item}]