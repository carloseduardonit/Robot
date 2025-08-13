# Estudos de Automação de Testes com Robot Framework - Basico ao Avançado
![.Env](https://img.shields.io/badge/.ENV-ECD53F.svg?style=for-the-badge&logo=dotenv&logoColor=black)
![Robot](https://img.shields.io/badge/Robot%20Framework-000000.svg?style=for-the-badge&logo=Robot-Framework&logoColor=white)
[![alt text](https://img.shields.io/badge/GitHub-181717.svg?style=for-the-badge&logo=GitHub&logoColor=white)](https://github.com/carloseduardonit/Robot/tree/main)
![alt text](https://img.shields.io/badge/GitHub%20Copilot-000000.svg?style=for-the-badge&logo=GitHub-Copilot&logoColor=white)
![alt text](https://img.shields.io/badge/gitignore.io-204ECF.svg?style=for-the-badge&logo=gitignoredotio&logoColor=white)
![alt text](https://img.shields.io/badge/Amazon-FF9900.svg?style=for-the-badge&logo=Amazon&logoColor=white)
![alt text](https://img.shields.io/badge/Python-3776AB.svg?style=for-the-badge&logo=Python&logoColor=white)
![alt text](https://img.shields.io/badge/Markdown-000000.svg?style=for-the-badge&logo=Markdown&logoColor=white)

# 🤖 Estudo e Prática com Robot Framework

Este repositório reúne **meus estudos, práticas e automações reais** com o uso do **Robot Framework**, voltado para **testes manuais e automatizados**, **RPA** e automação de processos como candidatura de vagas em sites como **Amazon**, **LinkedIn** e **Gupy**.

Aqui você encontrará códigos reutilizáveis, casos de teste reais, experimentos com Selenium, captura de evidências e organização de fluxos para projetos futuros.


## Curso de Robot ![alt text](https://img.shields.io/badge/Robot%20Framework-000000.svg?style=for-the-badge&logo=Robot-Framework&logoColor=white)
![alt text](https://img.shields.io/badge/Udemy-A435F0.svg?style=for-the-badge&logo=Udemy&logoColor=white)

### Backlog
- [ ] [Robot Framework: automatizando testes no padrão BDD](https://cursos.alura.com.br/course/robot-framework-testes-padrao-bdd)

### To Do
- [ ] [Automação de Testes com Robot Framework - Avançado](https://www.udemy.com/course/automacao-de-testes-com-robot-framework-avancado/?couponCode=KEEPLEARNINGBR)

### In Progress
- [ ] [Automação de Testes com Robot Framework - Básico](https://www.udemy.com/course/automacao-de-testes-com-robot-framework-basico/?couponCode=KEEPLEARNINGBR)
- [ ] [Robot Framework - Hora QA - PlayList](https://www.youtube.com/watch?v=Ua6KaBvAuWw&list=PLeE4t9Tme9VIPrx37F1EO0uk3vVweUZns)

## 📂 Estrutura do Projeto

- **tests/**: Contém os casos de teste.
  - `Amazon/`
    - `Amazon_test.robot`
  - `Linkedin/`
    - `linkedin_test.robot`: Script principal de automação.
    - `linkedin_locator.robot`: Variaveis Principal elementos da automação 
    - 
  - `Salesforce/`
    - `Salesforce_test.robot`
- **resources/**: Armazena recursos auxiliares.
  - `keywords_amazon.robot`: Conjunto de palavras-chave personalizadas.
  - `keywords_linkedin.robot`: Conjunto de palavras-chave personalizadas.
  - `keywords_.robot`: Conjunto de palavras-chave personalizadas.
- **results/**: Diretório onde os resultados das execuções são armazenados.
- `README.md`: Documentação do projeto.

## ⚙️ Configurações

### Python


- **Criar o Ambiente Virtual**
``` dos
    python -m venv .venv
```
- **Atualizar o Python do Ambiente Virtual**
``` dos
    python -m venv .venv --upgrade
```
- **Atualizar  dependências  do Ambiente virtual**
``` dos
     python -m venv .venv --upgrade-deps
```

- **Ativar o Ambiente Virtual**
``` dos
    .venv\Scripts\activate
```
- **Instalar as Dependências do Projeto**
``` dos
    pip install -r requirements.txt
```
---
- **Verificar a  versão do Python:**

``` dos
    python -v
```

- **Verificar  biblioteca instalada:**

``` dos
    pip freeze
```

- **Instalar Robot Framework e Verificar a versão do Robot Framework:**

``` dos
    pip install --upgrade robotframework
    robot --version
```
- **Instalar ou Atualizar Selinium Library**
```dos
    pip install --upgrade robotframework-seleniumlibrary
```
- **Instalar ou Atualizar Request Library**
```dos
   pip install --upgrade robotframework-requests
```
- **Instalar ou atualizar Library Faker**
```dos
    pip install robotframework-faker
```
- **Verificar as Librarys do Python**
```dos
    pip list
```
### Robot Framework

#### Amazon
**Executar a suite de teste do Amazon**
``` dos
    robot .\test\Amazon\Amazon_test.robot
```
**Executar o teste "Caso de teste 01: Acesso ao menu Livros" a suite de teste do Amazon**
``` dos
    robot --test "Caso de teste 01: Acesso ao menu Livros" .\test\Amazon\Amazon_test.robot
```
**Executar o teste "Casos de teste 02: Pesquisar por um produto" a suite de teste do Amazon**
``` dos
    robot --test "Caso de teste 01: Acesso ao menu Livros" .\test\Amazon\Amazon_test.robot
```

---
#### Linkedin
**Executar a suite de teste do Linkedin**
``` dos
    robot .\test\LinkedIn\linkedin_test.robot
```
**Executar o teste "Acessar o cartoes de Vagas" suite de teste do Linkedin**
``` dos
    robot --test "Acessar o cartoes de Vagas" .\test\LinkedIn\linkedin_test.robot
```

---
#### Salesforce
**Executar a suite de teste do Salesforce**
``` dos
    robot .\test\Salesforce\Salesforce_test.robot
```

### Atalho no Chorme

``` gherkin
      Dado  que  usuario esta no Chorme 
        E desejar  acessar DevTools
      Quando pressionar a tecla "F12"
      Então o navegador deverá  exibir o DevTools na Seção "Elementos"
```

``` gherkin
      Dado  que  usuario esta no DevTools
      Quando  pressionar  a tecla "CTRL" + "F"
      Então  o  navegador  deverá exibir o buscador de Elementos
```

## 🚀 Como Executar  
``` dos
```

1. **Clone este repositório**  
```sh
   git clone https://github.com/carloseduardonit/Robot.git
```

## Biblioteca

- [Biblioteca do Pytron](https://pypi.org/)
- [Documentação do venv](https://docs.python.org/pt-br/dev/library/venv.html)
- [Site oficial](https://robotframework.org/)
- TruePath
  - [chromewebstore](https://chromewebstore.google.com/detail/truepath/mgjhkhhbkkldiihlajcnlfchfcmhipmn?hl=pt)
  - [addons.mozilla](https://addons.mozilla.org/pt-BR/firefox/addon/truepath/)
- Driver
  - [chromedriver 32](https://storage.googleapis.com/chrome-for-testing-public/132.0.6834.83/win32/chromedriver-win32.zip)
  - [chromedriver 64](https://storage.googleapis.com/chrome-for-testing-public/132.0.6834.83/win64/chromedriver-win64.zip)
  - [geckodriver 32](https://github.com/mozilla/geckodriver/releases/download/v0.35.0/geckodriver-v0.35.0-win32.zip)
  - [geckodriver 64](https://github.com/mozilla/geckodriver/releases/download/v0.35.0/geckodriver-v0.35.0-win-aarch64.zip) 
    - [como configurar geckodriver no windows](https://pedrohjmartins.medium.com/como-configurar-geckodriver-no-windows-d32d1c5d5f8d)
- Library
  - [RPA.Browser.Selenium](https://rpaframework.org/libraries/browser_selenium/index.html)
  - [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#library-documentation-top)
  - [String](https://robotframework.org/robotframework/latest/libraries/String.html)
  - [ExcelRobot](https://zero88.github.io/robotframework-excel/docs/ExcelRobot.html)