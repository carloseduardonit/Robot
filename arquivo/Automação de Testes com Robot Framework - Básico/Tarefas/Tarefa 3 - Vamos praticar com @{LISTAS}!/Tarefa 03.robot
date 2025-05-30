*** Settings ***
*** Variables ***
@{Empregos}    'QA'   'TESTER'    'DESENVOLVERDOR'
@{Cidades}    'São Paulo'   'Rio de Janeiro'    'Belo Horizonte'
@{Nomes}    'João'   'Maria'    'José'
@{Meses}    'Janeiro'   'Fevereiro'    'Março'   'Abril'    'Maio'    'Junho'    'Julho'    'Agosto'    'Setembro'    'Outubro'    'Novembro'    'Dezembro'

*** Keywords ***
Obter Mes
    [Arguments]    ${mes}
    [Tags]    mes
    [Documentation]    Obter do mês
    Log    O mês ${mes}
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

Listar Meses
    [Documentation]    Listar os meses do ano com o loop FOR
    [Tags]    meses
    FOR    ${mes}    IN    @{Meses}
        Obter Mes    ${mes}
    END

Listar mes
    [Documentation]    Listar os meses do ano sem o loop FOR
    [Tags]    meses
    Obter Mes    ${Meses[0]}
    Obter Mes    ${Meses[1]}
    Obter Mes    ${Meses[2]}
    Obter Mes    ${Meses[3]}
    Obter Mes    ${Meses[4]}
    Obter Mes    ${Meses[5]}
    Obter Mes    ${Meses[6]}
    Obter Mes    ${Meses[7]}
    Obter Mes    ${Meses[8]}
    Obter Mes    ${Meses[9]}
    Obter Mes    ${Meses[10]}
    Obter Mes    ${Meses[11]}