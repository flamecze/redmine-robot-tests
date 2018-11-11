*** Settings ***
Resource  ../Settings/Imports.txt
Test Setup     Open Redmine And Login  ${url}  ${browser}  ${username}  ${password}
Test Teardown  Close Browser

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
    Jump on tab        ${tab_members} 
    Add new member     ${new_member} 
    Wait Until Element Contains		${project_member_table}		${new_member}               
        