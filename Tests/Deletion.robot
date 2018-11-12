*** Settings ***
Resource  ../Settings/Imports.txt
Suite Setup    Initialize User
Test Setup     Open Redmine And Login  ${url}  ${browser}  ${login_del}  ${password_del}
Test Teardown  Close Browser

*** Keywords ***
Initialize User
    ${login_random} =   Generate Random String    10    [LETTERS]
    ${email_random} =   Generate Random String    15    [LETTERS][NUMBERS]
    ${login_del} =      Set Variable   User_${login_random}
    ${email_del} =      Set Variable   ${login_random}@email.cz
    Set Suite Variable  ${login_del}
    Set Suite Variable  ${email_del}
    Open Redmine        ${url}      ${browser}
    Register User       ${login_del}    ${password_del}    ${email_del}    ${name}    ${surname}    ${en_value}
    Close Browser

*** Test Cases ***
Delete User
    Click Element    ${account}
    Click Element    ${trashbin}
    Click Element    ${check_box}
    Click Element    ${delete}
    Page Should Contain Element    ${delete_msg_box}