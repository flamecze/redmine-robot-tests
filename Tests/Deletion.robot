*** Settings ***
Resource  ../Settings/Imports.txt
Test Setup     Open Redmine And Login  ${url}  ${browser}  ${username}  ${password}
Test Teardown  Close Browser

*** Test Cases ***
Valid Login To Readmine
    Click Element    ${account}
    Click Element    ${trashbin}
    Click Element    ${delete}
  
