*** Settings ***
Resource  ../Settings/Imports.txt
Test Setup     Open Redmine  ${url}  ${browser}
Test Teardown  Close Browser

*** Test Cases ***

Registration - Happy Path
    Click Element    ${reg_link}
    Input Text    ${user_field}   ${login}
    Input Text    ${pwd_field}     ${reg_pwd}
    Input Text    ${confirm_field}    ${reg_pwd}
    Input Text    ${mail_field}    ${email}
    Input Text    ${name_field}    ${name}		    
    Input Text    ${surname_field}    ${surname}	
    Select From List By Value    ${lang_dropdown}    ${en_value}
    Click Button    ${btn_submit}
    Page Should Contain Element    ${reg_confirm}     

Try to send empty reg form

    
Try less than 4 chars pwd
