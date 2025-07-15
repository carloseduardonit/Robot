*** Settings ***
Library     RPA.Browser.Selenium
#Library     Browser
Library     String
Library    RPA.Smartsheet
Resource    ../linkedin_locator.robot
Resource    ../linkedin_suporte.robot
Resource    linkedin_candidatura_gupy.robot
Resource    linkedin_candidatura_simplificada.robot
Resource    linkedin_questoes.robot
*** Variables ***
${Vaga_Fechada}    //div[@class='job-card-container__footer-item--highlighted display-block t-12 pt1'][contains(.,'Não exibiremos mais esta vaga a você.')]

*** Keywords ***
path do Link do Cartão da Vaga de Numero "${numero_item}"
    [Documentation]    Link do Cartão da Vaga
    [Tags]    Link    No_Test
    RETURN From Keyword  //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//a

Acesso as "${Paginas}" paginas dos cartoes de vagas e as vagas
    [Documentation]    Acesso as "${Paginas}" paginas dos cartoes de vagas e as vagas
    [Tags]    Linkedin    NOK

    Set Local Variable    ${pagina}     1
    WHILE    ${pagina} <= ${Paginas}
        Acesso as vagas
        Manipular Element    ${botao_avançarPaginaCartao}
        Sleep    150
        Capture Page Screenshot   pagina ${pagina}.png
    END
    
A "${numero_item}"º vaga está candidatada?
    [Documentation]    Esta candidato a esta vaga?
    [Tags]    validação     OK

    ${Candidatou} =  Set Variable     //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//li[contains(.,'Candidatou-se')]
    ${resposta} =  Is Element Visible   ${Candidatou}
    Return From Keyword IF   ${resposta}    True
    Return From Keyword  False

A "${numero_item}"º vaga está fechada?
    [Documentation]    Esta vaga está fechada
    [Tags]   Validação    OK
    ${nao_exibir} =  Set Variable    //div[contains(@class,'job-card-container--viewport-tracking-${numero_item}')]//div[contains(.,'Não exibiremos mais esta vaga a você.')]
    ${resposta} =  Is Element Visible   ${nao_exibir}
    Return From Keyword IF   ${resposta}    True
    Return From Keyword  False

Vaga desejada
    [Documentation]    Vaga desejada
    [Tags]    ON
    [Arguments]    ${contador}
    ${Resposta} =  A "${contador}"º vaga está candidatada?
    IF    not ${Resposta}
        Acessar o cartao da Vaga    ${contador}  
        Faça a Candidatura da vaga simplificada
    END
    # Fechar o cartao da Vaga   ${${contador} + 1}

