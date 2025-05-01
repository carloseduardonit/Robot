# Title: LinkedIn Locators
*** Settings ***
Variables   ../LinkedIn/linkedin.py
*** Variables ***
# cartaosVagas =   ("//li[contains(@class,'list-item')]")
# va = ("//div[@data-view-name='job-card']")

# tela de login
${campo_login}       //input[@id='username']
${campo_senha}      //input[@id='password']
${botao_submit}    //button[contains(@type,'submit')]

# Campos de pesquisas
${campoSeach}    //input[contains(@class,'basic-input jobs-search-box__text-input jobs-search-box__keyboard-text-input jobs-search-global-typeahead__input')]

# Titulos
${h3_nome}      //h3[contains(.,'${name}')]
#${h2_title}    //h2[contains(.,'Conheça as oportunidades')]
${h2_title}    //h2[contains(.,'Vagas selecionadas para você')]

#  Botao da Filtragem de vagas
${botao_filtragemVagaSimplificada}    //button[@aria-label='Filtro Candidatura simplificada.']

# Path do progresso da candidatura
${path_progresso}   //progress

# Botao da Candidatura simplificada
${botao_iniciarCandidaturaVagaSimplificada}          //span[@class='artdeco-button__text'][contains(.,'Candidatura simplificada')][1]
${botao_avancarCandidatura}       //span[@class='artdeco-button__text'][contains(.,'Avançar')]
${botao_revisarCandidatura}      //span[@class='artdeco-button__text'][contains(.,'Revisar')]
${botao_enviarCandidatura}      //span[@class='artdeco-button__text'][contains(.,'Enviar candidatura')]
${botao_concluirCandidatura}    //span[@class='artdeco-button__text'][contains(.,'Concluido')]
${botao_finalizarCandidatura}  //button[@class='artdeco-button artdeco-button--circle artdeco-button--muted artdeco-button--2 artdeco-button--tertiary ember-view artdeco-modal__dismiss']

${botao_avançarPaginaCartao}    //button[@aria-label='Ver próxima página'][contains(.,'Avançar')]
# Variaveis de controle
${progresso_valor}  0
${contador}  -1
${test}
${item}  

# Variaveis de  inclusão de  contato
${div_contatos}    //div[@data-view-name='search-entity-result-universal-template']
${botao_Seguir}    //button[contains(.,'Seguir')]
${botao_Conectar}  //button[contains(.,'Conectar')]
${botao_EnviarSemNota}    //button[contains(@aria-label,'Enviar sem nota')]
${botao_AdicionarNota}    //button[contains(@aria-label,'Adicionar nota')]