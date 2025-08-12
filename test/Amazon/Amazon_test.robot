*** Settings ***
Resource    ../../resources/keywords_amazon.robot
Library    SeleniumLibrary
# Test Setup    Open Amazon
# Test Teardown    Close Amazon

**** Variables ***

${produto}     Xbox Series S

*** Test Cases ***

Caso de teste 01: Acesso ao menu Livros
    Acessar a home page do site Amazon.com.br
    Entrar no menu "Livros"
    Capture Page Screenshot    menu_livros.png
    
Casos de teste 02: Pesquisar por um produto
    Acessar a home page do site Amazon.com.br
    Pesquisar por um produto    ${produto}
    Capture Page Screenshot    pesquisar_produto.png