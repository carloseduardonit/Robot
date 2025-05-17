*** Settings ***
*** Variables ***
@{Empregos}    'QA'   'TESTER'    'DESENVOLVERDOR'
@{Cidades}    'São Paulo'   'Rio de Janeiro'    'Belo Horizonte'
@{Nomes}    'João'   'Maria'    'José'

*** Keywords ***

Criar Contato
    [Arguments]    ${nome}    ${cidade}    ${emprego}
    [Tags]    contato
    Log    Criando contato com nome: ${nome}, cidade: ${cidade}, emprego: ${emprego}
    # Aqui você pode adicionar a lógica para criar o contato

*** Test Cases ***
Criar Contatos
    [Documentation]    Criar contatos com diferentes combinações de nome, cidade e emprego
    [Tags]    contato
    FOR    ${nome}    IN    @{Nomes}
        FOR    ${cidade}    IN    @{Cidades}
            FOR    ${emprego}    IN    @{Empregos}
                Criar Contato    ${nome}    ${cidade}    ${emprego}
            END
        END
    END
Criar Contatos
    Criar Contato    ${Nomes[0]}    ${Cidades[0]}    ${Empregos[0]}
    Criar Contato    ${Nomes[1]}    ${Cidades[1]}    ${Empregos[1]}
    Criar Contato    ${Nomes[2]}    ${Cidades[2]}    ${Empregos[2]}