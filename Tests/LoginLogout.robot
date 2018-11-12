*** Settings ***
Resource  ../Settings/Imports.txt
Test Setup     Open Redmine  ${url}  ${browser}
Test Teardown  Close Browser

*** Test Cases ***
Login With Invalid Credentials
  Login To Redmine     ${username}    ${password}
  Verify Error Messages    ${invalidlogin}
  
Valid Login To Readmine
  Login To Redmine     ${username}    ${short_pwd}
    
Valid Logout From Readmine
  Click Element    ${logout}