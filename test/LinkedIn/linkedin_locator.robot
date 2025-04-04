# Title: LinkedIn Locators
*** Settings ***
Variables   ../LinkedIn/linkedin.py
*** Variables ***
# cartaosVagas =   ("//li[contains(@class,'list-item')]")
# va = ("//div[@data-view-name='job-card']")

# Campos de pesquisas
${campoSeach}    //input[contains(@class,'basic-input jobs-search-box__text-input jobs-search-box__keyboard-text-input jobs-search-global-typeahead__input')]

# Titulos
${h3.nome}      //h3[contains(.,'${name}')]
${h2.title}    //h2[contains(.,'Vagas selecionadas para você')]

#  Botao da Filtragem de vagas
${botao.filtragemVagaSimplificada}    //button[@aria-label='Filtro Candidatura simplificada.']

${botao_vagaSimplificada}   //span[@class='artdeco-button__text'][contains(.,'Candidatura simplificada')][1]
${botao_avancarCandidatura}       //span[@class='artdeco-button__text'][contains(.,'Avançar')]
${botao_revisarCandidatura}      //span[@class='artdeco-button__text'][contains(.,'Revisar')]
${botao_enviarCandidatura}      //span[@class='artdeco-button__text'][contains(.,'Enviar candidatura')]
${botao_concluirCandidatura}    //span[@class='artdeco-button__text'][contains(.,'Concluido')]
${botao_finalizarCandidatura}  //button[@class='artdeco-button artdeco-button--circle artdeco-button--muted artdeco-button--2 artdeco-button--tertiary ember-view artdeco-modal__dismiss']
