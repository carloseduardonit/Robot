*** Settings ***
Library    RPA.Browser.Selenium
*** Variables ***
${pergunta}=   //label[contains(.,'Como esta sua expectativa de valor no CLT?')]
${input_resposta}=  //input[contains(@class,'error-field artdeco-text-input--input')]
${selecionar_resposta}=     //select[contains(@aria-describedby,'text-entity-list-form-component-formElement-urn-li-jobs-applyformcommon-easyApplyFormElement-4243028816-20049339042-multipleChoice-error')]
&{q1}    pergunta=For how long have you worked as a Tester?     
...      resposta=I have worked as a QA Manual Engineer for 2 years, focusing on manual testing, mobile testing, and accessibility (AX). During this time, I also gained experience using tools like Zephyr and Jira, and I'm currently deepening my knowledge in API testing and test automation with frameworks like Robot.
&{q2}    pergunta=For how long have you worked with Automation testing?    
...      resposta=I'm currently gaining experience with automation testing. I've been studying and applying it in personal and training projects using the Robot Framework, focusing on semi-automated testing. While my main background is in manual testing, I'm actively expanding into automation to strengthen my QA skills.
&{q3}    pergunta=With which QA Automation tools have you worked? Ex. Selenium, Cypress, Cucumber, etc    
...      resposta=I have worked with the Robot Framework for semi-automated testing, using it mainly in training and personal projects. While I haven't used tools like Selenium or Cypress professionally yet, I have studied their concepts and I'm gradually expanding my knowledge to include these tools as part of my transition into automation testing.
&{q4}    pergunta=linkedin
...      resposta=https://www.linkedin.com/in/carlos-eduardo-dos-s-figueiredo/
&{q5}    pergunta=github
...      resposta=
&{q6}    pergunta=Como ficou sabendo da nossa vaga?
...      resposta=LinkedIn
&{q7}    pergunta=Qual o seu nível de inglês?
...      resposta=Intermediário
&{q8}    pergunta=Você possui algum familiar (como pais, irmãos, sogros, cunhados, cônjuges, ou filhos, enteados, padrasto/madrasta, genro/ nora, amigo íntimo ou pessoa próxima (com quem você tem um relacionamento significativo e contínuo) que atualmente trabalha na CI&T?
...      resposta=Não
&{q9}    pergunta=Você possui alguma deficiência?
...      resposta=Não
&{q10}   pergunta=Qual sua pretensão salarial?
...      resposta=5000.00
@{gestoes}     ${q1}    ${q2}    ${q3}    ${q4}    ${q5}    ${q6}    ${q7}    ${q8}
...            ${q9}    ${q10}

*** Keywords ***
Gerar patch para pergunta "${pergunta}"
    [Tags]     No_Test
    ${patch}=  //label[contains(.,'${pergunta}')]
    RETURN    ${patch}

Gerar patch para resposta "${resposta}"
    ${patch}=  //input[contains(.,'${resposta}')]
    ${auxiliar}=  Element Should Be Visible    locator=${patch}
    IF   '${auxiliar}' == 'True'
        Set Focus To Element    ${patch}
        Click Element    ${patch}     
    END
    RETURN    ${patch}

Preencher Formulário
    [Arguments]    ${gestoes}
    ${formulario}=    Create Dictionary
    FOR    ${questao}    IN    @{gestoes}
        ${questao_dict}=    Set Variable    ${questao}
        ${pergunta}=    Get From Dictionary    ${questao_dict}    pergunta
        ${resposta}=    Get From Dictionary    ${questao_dict}    resposta
        Set To Dictionary    ${formulario}    ${pergunta}    ${resposta}
    END
    Log    ${formulario}

Preencher a questão
