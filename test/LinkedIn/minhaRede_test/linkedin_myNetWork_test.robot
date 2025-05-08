*** Settings ***
Library    RPA.Browser.Selenium
Resource   ../linkedin_locator.robot
Resource   ../linkedin_suporte.robot

*** Variables ***

*** Keywords ***
Seguir os contatos
    #Wait Until Element Is Visible    ${botao_Seguir}
    [Documentation]    Seguir o contato em porcesso de desenvolvimento
    [Arguments]    ${numero_item}=1
    [Tags]    contato  NOK
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
    [Tags]    contato  NOK
    
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
    ELSE
        Log    message= São ${quantidade_contatos} contatos para conectar
    END
    FOR    ${contador}    IN RANGE    0   ${quantidade_contatos}
        Conectar ao Contato    ${${contador} + 1}
    END

Conectar ao Contato
    [Documentation]    Concetar ao Contato em porcesso de desenvolvimento
    [Arguments]    ${numero_item}=1
    [Tags]    contato 

    ${item} =  Set Variable      ${botao_Conectar}[${numero_item}]
    log  message= ${item}
    Manipular Element    ${item}
    Capture Element Screenshot    ${item}    filename=conectar-contato-${numero_item}.png
    Sleep   15
    Manipular Element   ${botao_EnviarSemNota}
    Sleep  15 
    