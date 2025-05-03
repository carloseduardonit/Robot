*** Settings **
Library    RPA.Browser.Selenium
Variables   ../../LinkedIn/linkedin.py
Resource    ../../LinkedIn/linkedin_locator.robot

*** Variables **
${loginLinkedin}    https://www.linkedin.com/login/pt?fromSignIn=true&trk=guest_homepage-basic_nav-header-signin

*** Keywords ***
## Acessar a home page do site Linkedin.com.br
Open Linkedin
    [Documentation]    Open Linkedin sem parametros
    [Tags]    login
    Open Browser   ${loginLinkedin}     chrome
    #...  options = add_experimental_option("detach", True)
    Set Window Size    1300   720
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