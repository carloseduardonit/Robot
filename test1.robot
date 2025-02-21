*** Settings ***
Documentation    Suite de testes para o site The Internet
Library    SeleniumLibrary
Library    OperatingSystem
    

*** Test Cases ***
Login with correct Username and Password
    [Documentation]    Teste de login com usuario e senha corretos
    [Tags]    login
    Open Browser    url=https://the-internet.herokuapp.com/login    browser=chrome
    Input Text    username    tomsmith
    Input Text    password    SuperSecretPassword!
    Click Button     class:radius
    Element Should Contain    id=flash    You logged into a secure area!
    Click Link    Logout
    Close Browser

Add Tasks And Set To Complete
    [Documentation]    Teste de adicionar tarefas e marcar como completas
    [Tags]    todo
    Open Browser    https://todomvc.com/examples/angular/dist/browser/#/    chrome
    Input Text    css:.new-todo    Complete Robot Framework Training
    Press Keys    css:.new-todo    RETURN
    Input Text    css:.new-todo    Write Automated Tests
    Press Keys    css:.new-todo    RETURN
    Input Text    css:.new-todo    Take a nap
    Press Keys    css:.new-todo    RETURN
    Element Text Should Be    class:todo-count    3 items left
    Click Element    xpath: //*[contains(text(), "Complete Robot Framework Training")]/../input
    Element Text Should Be    class:todo-count    2 items left
    Click Element    xpath: //*[contains(text(), "Write Automated Tests")]/../input
    Element Text Should Be    class:todo-count    1 item left
    Click Element    xpath: //*[contains(text(), "Take a nap")]/../input
    Element Text Should Be    class:todo-count    0 items left
    Close Browser