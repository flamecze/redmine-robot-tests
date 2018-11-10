*** Settings ***
Resource  ../Settings/Imports.txt
Test Setup     Open Redmine  ${url}  ${browser}
Test Teardown  Close Browser

*** Test Cases ***

Change Settings
    Login To Redmine     ${username}    ${password}
    Click Element    ${account}
    Input Text    ${name_field}  ${change_name}
    Input Text    ${surname_field}     ${change_surname}
    Click Button    ${save_btn}
    Page Should Contain Element    ${reg_confirm}     
    
Change Settings Empty Fields
    Login To Redmine     ${username}    ${password}
    Click Element    ${account} 
    Input Text   ${name_field}    ${EMPTY}
    Input Text    ${surname_field}    ${EMPTY}
    Click Button    ${save_btn}
    Page Should Contain Element    ${empty_name}
    Page Should Contain Element    ${empty_surname}
               
    