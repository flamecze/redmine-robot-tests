*** Settings ***
Resource  ../Settings/Imports.txt
Test Setup     Open Redmine  ${url}  ${browser}
Test Teardown  Close Browser

*** Test Cases ***
New project and subproject
    Login To Redmine    ${username}    ${password}
    Top menu select    ${project_href}    ${project_new}
    Create project    ${project_name}
    Wait Until Page Contains Element	${project_msg} 								
	Wait Until Element Contains		${project_msg}		${project_succ}
	Top menu select    ${project_href}    ${project_new}
    Jump via select     ${project_name}
    Wait Until Page Contains Element    ${subproject_new}
    Create subproject    ${subproject_name} 
    Wait Until Page Contains Element	${project_msg} 								
	Wait Until Element Contains		${project_msg}		${project_succ}      

Same project name
    Login To Redmine    ${username}    ${password}
    Top menu select    ${project_href}    ${project_new}
    Create project    ${project_name}
    Wait Until Page Contains Element	${project_msg_err} 								
	Wait Until Element Contains		${project_msg_err}		${project_err}
    
Search project via input
    Login To Redmine    ${username}    ${password}
    Search via input    ${project_name}          
    
Add member to project
    Login To Redmine    ${username}    ${password}
    Jump via select    ${project_name}
    Jump on tab        ${tab_members} 
    Add new member     ${new_member} 
    Wait Until Element Contains		${project_member_table}		${new_member}               
        