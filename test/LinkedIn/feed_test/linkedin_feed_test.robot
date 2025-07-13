*** Settings ***
Library    RPA.Browser.Selenium
Resource   ../linkedin_locator.robot


*** Variables ***
# | QA Intern | QA Traine | QA Associate | QA Manual Tester | QA Analyst | QA Specialist | QA Consultant | QA Automation Intern | QA Automation Trainee | QA Automation Associate | QA Automation Tester | QA Automation Engineer | QA Automation Specialist | QA Automation Consultant | QA Lead | QA Automation Lead | QA Architect | QA Automation Architect | QA Manager | QA Automation Manager | QA Director | QA Automation Director |

# | Estagiário de Contabilidade | Traine de Contabilidade | Auxiliar de Contabilidade | Assistente de Contabilidade | Técnico de Contabilidade | Analista de Contabilidade | Contador | Auditor | Controller | Analista Fiscal | Analista Tributário | Analista de Custos | Analista de Contas a Pagar | Analista de Contas a Receber | Analista de Folha de Pagamento | Analista de Tesouraria | Analista de Controladoria | Analista de Orçamento | Analista de Planejamento Financeiro | Analista de Auditoria Interna | Analista de Auditoria Externa | Analista de Compliance | Analista de Riscos Financeiros | Analista de Controle Interno | Analista de Relatórios Financeiros | Analista de Consolidação Financeira | Analista de Contabilidade Gerencial | Analista de Contabilidade Internacional | Analista de Contabilidade Tributária | Analista de Contabilidade Financeira | Analista de Contabilidade de Custos | Analista de Contabilidade de Patrimônio | Analista de Contabilidade de Receitas | Analista de Contabilidade de Despesas | Analista de Contabilidade de Ativos | Analista de Contabilidade de Passivos |

# | Java Developer | Java Engineer | Java Programmer | Java Software Engineer | Java Software Developer | Java Application Developer | Java Web Developer | Java Backend Developer | Java Frontend Developer | Java Full Stack Developer | Java Mobile Developer | Java Cloud Developer |

${job}     Java junior
${cidade}      São Paulo, 
${Pais}    Brasil
${Modalidade}    (Remoto)
${span_Local_Vaga}      //span[contains(.,'${cidade} ${Pais} ${Modalidade}')]
${urlJob}    https://www.linkedin.com/jobs/

*** Keywords ***
Obter termo de pesquisa 
    [Documentation]    Retorna o termo de pesquisa para uso no campo de busca do LinkedIn.
    ...                Caso o parâmetro ${aspas} seja True, o valor será retornado entre aspas duplas (ex: "QA Analyst").
    ...                Caso seja False (padrão), retorna o termo limpo, sem aspas.
    [Arguments]    ${job}    ${aspas}=False
    [Tags]    No_Test
    ${aspas} =   Convert To Boolean    ${aspas}
    Return From Keyword If    ${aspas}    "${job}"
    Return From Keyword    ${job}

Pesquisar para emprego no Linkedin
    [Documentation]    Pesquisa vagas no LinkedIn com base no termo de cargo desejado 
    ...                e captura a tela dos resultados.
    [Tags]    Pesquisar_emprego
    Wait Until Element Is Visible   locator=${h3_nome}    timeout=15
    RPA.Browser.Selenium.Go To    ${urlJob}
    
    Element Should Be Visible    ${h2_title}   timeout=15
    ${Auxiliar}=  Obter termo de pesquisa    ${job}     ${true}
    Input Text    ${campoSeach}   ${Auxiliar}
    RPA.Browser.Selenium.Press Keys    ${campoSeach}    ENTER
    Sleep    15
    Capture Page Screenshot    Vagas de ${job}.png
