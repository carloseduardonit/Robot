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
${h2_title}    //h2[contains(.,'Vagas que mais combinam com seu perfil')]

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

# Variaveis de controle
${progresso_valor}  0
${contador}  -1
${test}
${item}  