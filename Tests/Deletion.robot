*** Settings ***
Resource  ../Settings/Imports.txt
Test Setup     Open Redmine And Login  ${url}  ${browser}  ${username_del}  ${password_del}
Test Teardown  Close Browser

*** Test Cases ***
Valid Login To Readmine
    Click Element    ${account}
    Click Element    ${trashbin}
    Click Element    ${check_box}
    Click Element    ${delete}
    Page Should Contain Element    ${delete_msg_box}