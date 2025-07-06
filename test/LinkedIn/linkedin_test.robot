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

# link
${link_Visulizar}     //a[contains(@class,'jobs-s-apply__application-link display-flex align-items-center ember-view')]

*** Keywords ***
Clique na filtragem do modelo Home Office
    [Documentation]   Clique na vaga Home Office
    [Tags]    button
    Wait Until Element Is Visible    locator=${botao.homeOffice}    timeout=15
    Click Button  ${botao.homeOffice}
    Sleep    150
    Capture Page Screenshot



    
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

# //div[@class='scaffold-layout__list ']
Acessar o cartoes de Vagas 
    [Documentation]    Acessar o cartão da Vaga
    [Tags]   cartaosVagas
    ${contador}      Set Variable      0
    Pesquisar para emprego no Linkedin
    Clique na filtragem da Candidatura simplificada
    #Reducao da tela do navegador   3
   
    Acesso as vagas
    Manipular Element    ${botao_avançarPaginaCartao}
    Acesso as vagas
    Manipular Element    ${botao_avançarPaginaCartao}
    Acesso as vagas
    #Acesso as "5" paginas dos cartoes de vagas e as vagas

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