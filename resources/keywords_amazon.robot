*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${link-livro}       //a[contains(.,'Livros')]
${title-livro}      Destaques em Livros
${path-title-livro}       //h3[contains(.,'${title-livro}')]
# -----------------------

*** Keywords ***
Open Amazon
    Open Browser    https://www.amazon.com.br/    chrome  
    ...  options = add_experimental_option("detach", True)
    Maximize Browser Window
    

Close Amazon
    Close Browser

Acessar a home page do site Amazon.com.br
    Open Amazon
    Set Window Size    10240    7680

Entrar no menu 
    [Arguments]    ${link}   ${path-titulo}  ${titulo}
    Sleep    15
    Click Element   ${link}
    Element Should Contain    ${path-titulo}     ${titulo}
Entrar no menu "${itemMENU}"
    Sleep    15
    Click Element  //a[contains(.,'${itemMENU}')]
    Capture Element Screenshot    //a[contains(.,'${itemMENU}')]   ${itemMENU}.png

Pesquisar por um produto
    [Arguments]    ${produto}
    Sleep    15
    Input Text    twotabsearchtextbox    ${produto}
    Click Button    nav-search-submit-button
    