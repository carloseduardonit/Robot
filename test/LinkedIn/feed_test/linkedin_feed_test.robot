*** Settings ***
Library    RPA.Browser.Selenium
Resource   ../linkedin_locator.robot


*** Variables ***
${job}      Analista de qualidade
${cidade}      São Paulo, 
${Pais}    Brasil
${Modalidade}    (Remoto)
${span_Local_Vaga}      //span[contains(.,'${cidade} ${Pais} ${Modalidade}')]
${urlJob}    https://www.linkedin.com/jobs/

*** Keywords ***

Pesquisar para emprego no Linkedin
    [Documentation]    Pesquisar para emprego no Linkedin
    [Tags]    Pesquisar_emprego
    Wait Until Element Is Visible   locator=${h3_nome}    timeout=150
    Go To    ${urlJob}
    Sleep  15
    Element Should Be Visible    ${h2_title}
    Input Text    ${campoSeach}   "${job}"
    Press Keys    ${campoSeach}    ENTER
    Sleep    15
    Capture Page Screenshot    Vagas de ${job}.png
