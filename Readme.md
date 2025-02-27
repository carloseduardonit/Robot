# Estudos de Automação de Testes com Robot Framework - Basico ao Avançado
![.Env](https://img.shields.io/badge/.ENV-ECD53F.svg?style=for-the-badge&logo=dotenv&logoColor=black)
![Robot](https://img.shields.io/badge/Robot%20Framework-000000.svg?style=for-the-badge&logo=Robot-Framework&logoColor=white)
[![alt text](https://img.shields.io/badge/GitHub-181717.svg?style=for-the-badge&logo=GitHub&logoColor=white)](https://github.com/carloseduardonit/Robot/tree/main)
![alt text](https://img.shields.io/badge/GitHub%20Copilot-000000.svg?style=for-the-badge&logo=GitHub-Copilot&logoColor=white)
![alt text](https://img.shields.io/badge/gitignore.io-204ECF.svg?style=for-the-badge&logo=gitignoredotio&logoColor=white)
![alt text](https://img.shields.io/badge/Amazon-FF9900.svg?style=for-the-badge&logo=Amazon&logoColor=white)
![alt text](https://img.shields.io/badge/Python-3776AB.svg?style=for-the-badge&logo=Python&logoColor=white)
![alt text](https://img.shields.io/badge/Markdown-000000.svg?style=for-the-badge&logo=Markdown&logoColor=white)

## Curso de Robot ![alt text](https://img.shields.io/badge/Robot%20Framework-000000.svg?style=for-the-badge&logo=Robot-Framework&logoColor=white)
![alt text](https://img.shields.io/badge/Udemy-A435F0.svg?style=for-the-badge&logo=Udemy&logoColor=white)

### Backlog
- [ ] [Robot Framework: automatizando testes no padrão BDD](https://cursos.alura.com.br/course/robot-framework-testes-padrao-bdd)

### To Do
- [ ] [Automação de Testes com Robot Framework - Avançado](https://www.udemy.com/course/automacao-de-testes-com-robot-framework-avancado/?couponCode=KEEPLEARNINGBR)

### In Progress
- [ ] [Automação de Testes com Robot Framework - Básico](https://www.udemy.com/course/automacao-de-testes-com-robot-framework-basico/?couponCode=KEEPLEARNINGBR)

## 📂 Estrutura do Projeto

- **tests/**: Contém os casos de teste.
  - `Linkedin/linkedin.robot`: Script principal de automação.
- **resources/**: Armazena recursos auxiliares.
  - `keywords.robot`: Conjunto de palavras-chave personalizadas.
- **results/**: Diretório onde os resultados das execuções são armazenados.
- `README.md`: Documentação do projeto.

## ⚙️ Configurações

### Python
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
    pip install robotframework
    robot --version
```
###
### Robot Framework
**Executar a suite de teste do Amazon**
``` dos
    robot '.\test\Amazon\Amazon_test.robot'
```

**Executar a suite de teste do Linkedin**
``` dos
    robot '.\test\LinkedIn\linkedin.robot'
```
**Executar a suite de teste do Salesforce**
``` dos
    robot '.\test\Salesforce\Salesforce.robot'
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
  - [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#library-documentation-top)
  - [ExcelRobot](https://zero88.github.io/robotframework-excel/docs/ExcelRobot.html)