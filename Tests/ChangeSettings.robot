*** Settings ***
Resource  ../Settings/Imports.txt
Suite Setup    Initialize User
Test Setup     Open Redmine And Login  ${url}  ${browser}  ${username}  ${password}
Test Teardown  Close Browser

*** Keywords ***
Initialize User
    ${login_random} =   Generate Random String    10    [LETTERS]
    ${email_random} =   Generate Random String    15    [LETTERS][NUMBERS]
    ${login} =          Set Variable   User_${login_random}
    ${email} =          Set Variable   ${login_random}@email.cz
    Set Suite Variable  ${login}
    Set Suite Variable  ${email}
    Open Redmine        ${url}      ${browser}
    Register User       ${login}    ${reg_pwd}    ${email}    ${name}    ${surname}    ${en_value}
    Close Browser

*** Test Cases ***
Change Settings
    Click Element    ${account}
    Input Text    ${name_field}  ${change_name}
    Input Text    ${surname_field}     ${change_surname}
    Click Button    ${save_btn}
    Page Should Contain Element    ${success_msg_box}
    
Change Settings Empty Fields
    Click Element    ${account} 
    Input Text   ${name_field}    ${EMPTY}
    Input Text    ${surname_field}    ${EMPTY}
    Click Button    ${save_btn}
    Page Should Contain Element    ${empty_name}
    Page Should Contain Element    ${empty_surname}
               
    