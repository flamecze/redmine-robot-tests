*** Settings ***
Resource  ../Settings/Imports.txt
Test Setup     Open Redmine  ${url}  ${browser}
Test Teardown  Close Browser

*** Test Cases ***
Valid Login To Readmine
    Login To Redmine     ${username}    ${password}
   Click Element    ${logout}
