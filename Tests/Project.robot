*** Settings ***
Resource  ../Settings/Imports.txt
Test Setup     Open Redmine And Login  ${url}  ${browser}  ${username}  ${password}
Test Teardown  Close Browser
Suite Setup    Initialize Random Data

*** Keywords ***
Initialize Random Data
    ${project_number} =   Generate Random String    4    [NUMBERS]
    ${project_name} =          Set Variable   Project_Team3_${project_number}
    ${subproject_name} =          Set Variable   Subproject_Team3_${project_number}
    Set Suite Variable  ${project_name}
    Set Suite Variable  ${subproject_name}

*** Test Cases ***
New project and subproject
    Top menu select    ${project_href}    ${project_new}
    Create project    ${project_name}
    Wait Until Page Contains Element	${success_msg_box}
	Wait Until Element Contains		${success_msg_box}		${project_succ}
	Top menu select    ${project_href}    ${project_new}
    Jump via select     ${project_name}
    Wait Until Page Contains Element    ${subproject_new}
    Create subproject    ${subproject_name}
    Wait Until Page Contains Element	${success_msg_box}
	Wait Until Element Contains		${success_msg_box}		${project_succ}

Same project name
    Top menu select    ${project_href}    ${project_new}
    Create project    ${project_name}
    Wait Until Page Contains Element	${error_msg_box}
	Wait Until Element Contains		${error_msg_box}		${project_err}

Search project via input
    Search via input    ${project_name}
    
Add member to project
    Jump via select    ${project_name}
    Jump to project settings tab       ${project_tab_members}
    Add new member     ${new_member} 
    Wait Until Element Contains		${project_member_table}		${new_member}               
        