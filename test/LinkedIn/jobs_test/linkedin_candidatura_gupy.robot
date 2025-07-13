*** Settings ***
Resource  linkedin_candidatura.robot
*** Keywords ***
Gerar Link da Gupy
   [Documentation]    Copia o link da vaga e verifica se pertence à Gupy (contém 'gupy.io').
    ...                Armazena o link válido na variável de suíte `${link_vaga}`, 
    ...                ou None se inválido.
    [Tags]    Link    No_Test
    ${url_gupy} =  Set Variable    gupy.io
    ${resposta}=     Copiar o link da vaga
    ${contem}=  Run Keyword And Return Status      
    ...    Should Contain    ${resposta}    ${url_gupy}
        
    IF    ${resposta} != ${None} and ${contem}
        Log    message=Link da vaga: ${resposta}
        Set Suite Variable    ${link_vaga}    ${resposta}
    ELSE
        Log    message=Link da vaga não encontrado
        Set Suite Variable    ${link_vaga}    ${None}
    END

