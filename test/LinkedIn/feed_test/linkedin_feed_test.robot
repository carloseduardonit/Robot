*** Settings ***
Library    RPA.Browser.Selenium
Resource   ../linkedin_locator.robot


*** Variables ***
#  | Analista de qualidade |  Quality Assurance Tester |  QA Analyst |  QA Engineer |  QA Automation Engineer |  QA Manual Tester |  QA Lead |  QA Manager |  QA Director |  QA Architect |  QA Consultant |  QA Specialist |  QA Associate |  QA Trainee |  QA Intern |
#  | QA Automation Tester |  QA Automation Architect |  QA Automation Lead |  QA Automation Manager |  QA Automation Director |  QA Automation Consultant |  QA Automation Specialist |  QA Automation Associate |  QA Automation Trainee |  QA Automation Intern |
#  | QA Automation Engineer |  QA Automation Tester |  QA Automation Architect |  QA Automation Lead |  QA Automation Manager |  QA Automation Director |  QA Automation Consultant |  QA Automation Specialist |  QA Automation Associate |  QA Automation Trainee |  QA Automation Intern 
#  | QA Automation Engineer |  QA Automation Tester |  QA Automation Architect |  QA Automation Lead |  QA Automation Manager |  QA Automation Director |  QA Automation Consultant |  QA Automation Specialist |  QA Automation Associate |  QA Automation Trainee |  QA Automation Intern |
# -----------
#  | Tecnico de contabilidade | analista de contabilidade |  contador |  auditor |  controller |  analista fiscal |  analista tributário |  analista de custos |  analista de contas a pagar |  analista de contas a receber |  analista de folha de pagamento |  analista de tesouraria |  analista de controladoria |  analista de planejamento financeiro |  analista de orçamento |
#  | auxiliar de contabilidade |  assistente de contabilidade |  estagiário de contabilidade |  trainee de contabilidade |  analista de auditoria interna |  analista de auditoria externa |  analista de compliance |  analista de riscos financeiros |  analista de controle interno |  analista de relatórios financeiros |  analista de consolidação financeira |
#  | analista de contabilidade gerencial |  analista de contabilidade internacional |  analista de contabilidade tributária |  analista de contabilidade financeira |  analista de contabilidade de custos |  analista de contabilidade de patrimônio |  analista de contabilidade de receitas |  analista de contabilidade de despesas |  analista de contabilidade de ativos |  analista de contabilidade de passivos |
${job}      QA
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
