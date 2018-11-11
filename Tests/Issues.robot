*** Settings ***
Resource  ../Settings/Imports.txt
Test Setup     Open Redmine And Login  ${url}  ${browser}  ${username}  ${password}
Test Teardown  Close Browser

*** Test Cases ***
Create Issue With Minimal Input
    Go To New Issue For Project        ${project_name_for_issues}
    Input Text                         ${issue_subject_input}           ${issue_subject}
    Wait For Successful Issue Submit   ${issue_subject}
    Delete Issue From Detail           ${issue_delete_link}             ${issue_title_el}

Create Issue With Filled Valid Values
    Go To New Issue For Project        ${project_name_for_issues}
    Input Text                         ${issue_subject_input}           ${issue_subject}
    Input Text                         ${issue_description_input}       ${issue_description}
    Input Text                         ${issue_start_date_input}        ${issue_start_date}
    Input Text                         ${issue_due_date_input}          ${issue_due_date}
    Input Text                         ${issue_estimated_hrs_input}     ${issue_estimated_hrs}
    Select From List By Label          ${issue_priority_input}          ${issue_priority}
    Select From List By Value          ${issue_done_ratio_input}        ${issue_done_ratio}
    Wait For Successful Issue Submit   ${issue_subject}
    Element Should Contain             ${issue_attrs_status}            ${issue_status}
    Element Should Contain             ${issue_attrs_priority}          ${issue_priority}
    Element Should Contain             ${issue_attrs_start_date}        ${issue_start_date_txt}
    Element Should Contain             ${issue_attrs_due_date}          ${issue_due_date_txt}
    Element Should Contain             ${issue_attrs_estimated_hours}   ${issue_estimated_hrs_formatted} hours
    Element Should Contain             ${issue_attrs_progress_perc}     ${issue_done_ratio}%
    Element Should Contain             ${issue_description_container}   ${issue_description}
    Delete Issue From Detail           ${issue_delete_link}             ${issue_title_el}

Create Issue Without Subject
    Go To New Issue For Project        ${project_name_for_issues}
    Click Button                       ${issue_btn_submit}
    Wait Until Page Contains Element   ${error_msg_box}
    Page Should Contain                ${issue_err_subject_blank}

Delete Issue
    Go To New Issue For Project        ${project_name_for_issues}
    Input Text                         ${issue_subject_input}           ${issue_subject}
    Wait For Successful Issue Submit   ${issue_subject}
    Delete Issue From Detail           ${issue_delete_link}             ${issue_title_el}

View Today's Issue In Calendar
    Go To New Issue For Project        ${project_name_for_issues}
    Input Text                         ${issue_subject_input}           ${issue_subject}
    Wait For Successful Issue Submit   ${issue_subject}
    ${title_text} =   Get Text         ${issue_title_el}
    Click Link                         ${project_calendar_href}
    Wait Until Element Contains        ${project_calendar_today_cell}   ${title_text}
    Go Back
    Delete Issue From Detail           ${issue_delete_link}             ${issue_title_el}

Create Issue Category
    Go To New Issue Category For Project  ${project_name_for_issues}
    ${category_name} =                    Generate Random String           20  [LETTERS]
    Input Text                            ${issue_cat_name_input}          Category_${category_name}
    Click Button                          ${issue_cat_btn_submit}
    Wait Until Element Contains           ${issue_cat_table}               Category_${category_name}

Create Issue Category Without Name
    Go To New Issue Category For Project  ${project_name_for_issues}
    Click Button                          ${issue_btn_submit}
    Wait Until Page Contains Element      ${error_msg_box}
    Page Should Contain                   ${issue_cat_err_name_blank}

Create Issue With Assignee
    Go To New Issue For Project        ${project_name_for_issues}
    Input Text                         ${issue_subject_input}           ${issue_subject}
    Select From List By Label          ${issue_assigned_to_input}       ${issue_assignee}
    Wait For Successful Issue Submit   ${issue_subject}
    Element Should Contain             ${issue_attrs_assigned_to}       ${issue_assignee}
    Delete Issue From Detail           ${issue_delete_link}             ${issue_title_el}

Edit Issue
    Go To New Issue For Project        ${project_name_for_issues}
    Input Text                         ${issue_subject_input}           ${issue_subject}
    Wait For Successful Issue Submit   ${issue_subject}
    Click Link                         ${issue_edit_link}
    Select From List By Label          ${issue_priority_input}          ${issue_priority}
    Press Key                          ${issue_subject_input}           \\13
    Page Should Contain Element        ${success_msg_box}
    Element Should Contain             ${issue_attrs_priority}          ${issue_priority}
    Delete Issue From Detail           ${issue_delete_link}             ${issue_title_el}

*** Keywords ***
Get Issue ID From Title
	[Arguments]	  ${title_el}
    ${title_text} =   Get Text          ${title_el}
    ${issue_id} =     Fetch From Right  ${title_text}   \#
    [Return]         ${issue_id}

Delete Issue From Detail
	[Arguments]	  ${delete_link}            ${title_el}
    ${issue_id} =     Get Issue ID From Title   ${title_el}
    Click Link        ${delete_link}
    Handle Alert
    Wait Until Page Does Not Contain   ${issue_id}

Go To New Issue Category For Project
	[Arguments]		               ${project_name_arg}
    Jump via select                    ${project_name_arg}
    Jump to project settings tab       ${project_tab_categories}
    Click Link                         ${issue_new_cat_link}

Go To New Issue For Project
	[Arguments]		               ${project_name_arg}
    Jump via select                    ${project_name_arg}
    Click Element                      ${issue_new_href}
    Wait Until Page Contains Element   ${issue_new_title}

Wait For Successful Issue Submit
	[Arguments]		               ${issue_subject}
    Click Button                       ${issue_btn_submit}
    Wait Until Element Contains        ${issue_subject_el}      ${issue_subject}
    Page Should Contain Element        ${success_msg_box}