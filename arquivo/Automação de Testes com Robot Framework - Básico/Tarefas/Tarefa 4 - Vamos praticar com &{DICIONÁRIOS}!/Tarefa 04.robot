*** Settings ***
*** Variables ***
&{Janeiro}      nome=Janeiro     DIA=31
&{Fevereiro}    nome=Fevereiro   DIA=28
&{Março}        nome=Março       DIA=31
&{Abril}        nome=Abril       DIA=30
&{Maio}         nome=Maio        DIA=31
&{Junho}        nome=Junho       DIA=30
&{Julho}        nome=Julho       DIA=31
&{Agosto}       nome=Agosto      DIA=31
&{Setembro}     nome=Setembro    DIA=30
&{Outubro}      nome=Outubro     DIA=31
&{Novembro}     nome=Novembro    DIA=30
&{Dezembro}     nome=Dezembro    DIA=31

@{Meses}        ${Janeiro}    ${Fevereiro}    ${Março}    ${Abril}    ${Maio}    ${Junho}    
...    ${Julho}   ${Agosto}    ${Setembro}    ${Outubro}    ${Novembro}    ${Dezembro}

&{Meses_Dias}    Janeiro=31    Fevereiro=28    Março=31    Abril=30    Maio=31    Junho=30    
...    Julho=31    Agosto=31    Setembro=30    Outubro=31    Novembro=30    Dezembro=31
&{Meses_Dias_Bissexto}    Janeiro=31    Fevereiro=29    Março=31    Abril=30    Maio=31    Junho=30    
...    Julho=31    Agosto=31    Setembro=30    Outubro=31    Novembro=30    Dezembro=31
${dias_validos}    

*** Keywords ***
Verifica se o ano é bissexto
    [Arguments]    ${ano}
    ${bissexto}    Set Variable If    ${ano} % 4 == 0 and (${ano} % 100 != 0 or ${ano} % 400 == 0)    True    False
    [Return]    ${bissexto}


Verifica se o mês é válido
    [Arguments]    ${mes}
    ${mes_valido}    Set Variable If    ${mes} in @{Meses_Dias} or ${mes} in @{Meses_Dias_Bissexto}    True    False
    [Return]    ${mes_valido}

Verifica se o dia é válido
    [Arguments]    ${dia}    ${mes}    ${ano}
    ${bissexto}    Verifica se o ano é bissexto    ${ano}
    ${mes_valido}    Verifica se o mês é válido    ${mes}
    
    Run Keyword If    '${mes}' == 'Fevereiro' and '${bissexto}' == 'True'    Set Variable    ${dias_validos}    @{Meses_Dias_Bissexto}[${mes}]
    ...    ELSE IF    '${mes}' == 'Fevereiro' and '${bissexto}' == 'False'    Set Variable    ${dias_validos}    @{Meses_Dias}[${mes}]


Obtem quantidade de dias do mes
    [Arguments]     ${dia}    ${mes} 
    Log    O mes ${mes} tem ${dia} dias

*** Test Cases ***
 
imprime mes e dia
    [Documentation]    Imprime o mês e o dia
    FOR    ${i}   IN RANGE    0   12    
        ${mes_nome}     Set Variable    ${Meses[${i}]}
        
        Obtem quantidade de dias do mes    ${mes_nome.DIA}    ${mes_nome.nome}
    END