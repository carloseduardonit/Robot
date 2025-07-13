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
    
Esta canditado a esta vaga?
    [Documentation]    Esta canditado a esta vaga?
    [Tags]    button     OK
    [Arguments]    ${numero_item}

    ${resposta} =  Is Element Visible   ${Li_Candidatou}[${numero_item}]
    Return From Keyword    ${resposta}
Esta vaga está fechada?
    [Documentation]    Esta vaga está fechada
    [Tags]   Validação    OK
    [Arguments]    ${numero_item}
    ${resposta} =  Is Element Visible   ${Vaga_Fechada}[${numero_item}]
    Return From Keyword    ${resposta}

Vaga desejada
    [Documentation]    Vaga desejada
    [Tags]    ON
    [Arguments]    ${contador}

    ${item} =   Set Variable     ${Li_Candidatou}[${contador}]
    ${Resposta} =  Is Element Visible    ${item}
    IF    not ${Resposta}
        Acessar o cartao da Vaga    ${contador}  
        Faça a Candidatura da vaga simplificada
    END
    # Fechar o cartao da Vaga   ${${contador} + 1}

