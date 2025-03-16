*** Settings ***
Library    RPA.Browser.Selenium
Variables   ../test/Linkedin/linkedin.py

*** Variables ***
${job} =    "QA"
${urlJob}    https://www.linkedin.com/jobs/
${loginLinkedin}    https://www.linkedin.com/login/pt?fromSignIn=true&trk=guest_homepage-basic_nav-header-signin
*** Keywords ***

Open Linkedin
    Open Browser   ${loginLinkedin}  firefox
    ...  options = add_experimental_option("detach", True)
    Maximize Browser Window
    Input Text    id=username   ${email}
    Input Password    id=password    ${senha}
    Click Button   //button[contains(@type,'submit')]
    Sleep    15

Close Linkedin
    Close Browser