*** Settings ***
Resource  ../Settings/Imports.txt
Library   String
Test Setup     Open Redmine  ${url}  ${browser}
Test Teardown  Close Browser
Suite Setup    Initialize Random Data

*** Keywords ***
Initialize Random Data
    ${login_random} =   Generate Random String    10    [LETTERS]
    ${email_random} =   Generate Random String    15    [LETTERS][NUMBERS]
    ${login} =          Set Variable   User_${login_random}
    ${email} =          Set Variable   ${login_random}@email.cz
    Set Suite Variable  ${login}
    Set Suite Variable  ${email}

*** Test Cases ***
Registration - Happy Path
    Register User    ${login}    ${reg_pwd}    ${email}    ${name}    ${surname}    ${en_value}

Try to send empty reg form
    Click Element    ${reg_link}
    Click Button    ${btn_submit}
    Page Should Contain Element    ${error_msg_box}

Try less than 4 chars pwd
    Click Element    ${reg_link}
    Input Text    ${user_field}   ${login}
    Input Text    ${pwd_field}     ${short_pwd}
    Input Text    ${confirm_field}    ${short_pwd}
    Input Text    ${mail_field}    ${email}
    Input Text    ${name_field}    ${name}
    Input Text    ${surname_field}    ${surname}
    Select From List By Value    ${lang_dropdown}    ${en_value}
    Click Button    ${btn_submit}
    Page Should Contain Element    ${error_msg_box}
    Element Should Contain    ${error_msg_box}    ${reg_err_pwd_short}