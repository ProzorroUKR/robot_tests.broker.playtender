*** Settings ***

Resource                                                        playtender_common.robot
Resource                                                        playtender_claim_variables.robot

*** Keywords ***


Створити вимогу
    [Arguments]                                                 ${username}  ${tender_uaid}  ${type}  ${type_id}  ${claim}  ${doc_name}
    [Documentation]                                             Створити вимогу з claim в описі для тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}
    click visible element                                       ${claim_page_open_btn_locator}
    capture page screenshot
    wait until page contains element with reloading             ${claim_form_open_btn_locator}
    open popup by btn locator                                   ${claim_form_open_btn_locator}
    capture page screenshot
    input text to exist visible input                           ${claim_form_complaintform_title_input_locator}  ${claim.data.title}
    capture page screenshot
    input text to exist visible input                           ${claim_form_complaintform_description_input_locator}  ${claim.data.description}
    capture page screenshot
    Run Keyword And Ignore Error                                Run Keyword If  '${type}' == 'tender'  Select From List By Label  ${claim_form_complaintform_related_of_input_locator}  Закупівля
    capture page screenshot
    Run Keyword And Ignore Error                                Run Keyword If  '${type}' == 'lot'  Select From List By Label  ${claim_form_complaintform_related_of_input_locator}  Лот
    capture page screenshot
    Run Keyword And Ignore Error                                Run Keyword If  '${type}' == 'lot'  Click Element  ${claim_form_complaintform_related_lot_input_locator}
    ${claim_form_complaintform_related_lot_select_locator} =    Run Keyword If  '${type}' == 'lot'   replace string  ${claim_form_complaintform_related_lot_input_locator_tpl}  %type_id%  ${type_id}
    Run Keyword And Ignore Error                                Run Keyword If  '${type}' == 'lot'  Click Element  ${claim_form_complaintform_related_lot_select_locator}
    capture page screenshot
    Run Keyword And Ignore Error                                Select From List By Label  ${claim_form_complaintform_complaintform_type_input_locator}  Вимога
    Run Keyword And Ignore Error                                Run Keyword If  '${type}' == 'winner_complaint' or '${claim.data.type}' == 'complaint'   Select From List By Label  ${claim_form_complaintform_complaintform_type_input_locator}  Скарга

    capture page screenshot
###    Run Keyword If  '${doc_name}' != 'null'                     click visible element   ${claim_form_complaintform_document_btn_locator}
    capture page screenshot
    Run Keyword If  '${doc_name}' != 'null'                     choose file   ${add_file_to_form_locator}  ${doc_name}
    capture page screenshot
    Run Keyword If  '${doc_name}' != 'null'                     wait until page does not contain element   ${popup_dynamic_form_loading_element_locator}
    capture page screenshot
#    Run Keyword If  '${doc_name}' != 'null'                     submit current visible popup
    submit form and check result                                ${claim_form_complaintform_submit_btn_locator}  ${claim_form_submit_success_msg}  ${tender_created_checker_element_locator}
#    Функция ожидания claim_uaid_text_locator соответствующей вимоги
#    click visible element                                       ${claim_form_open_btn_locator}
    reload page
    wait until page does not contain element with reloading     ${claim_sync_element_locator}  60
    wait until page contains element with reloading             ${claim_uaid_text_locator}
    ${return_value}=                                            get text  ${claim_uaid_text_locator}
    ${return_value}=                                            Convert To String  ${return_value}
    [return]                                                    ${return_value}

Скасувати вимогу
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}  ${award_index}
    [Documentation]                                             Перевести вимогу complaintID  для тендера tender_uaid у статус cancelled,
    ...                                                         використовуючи при цьому дані confirmation_data.

    open tender page by uaid                                    ${tender_uaid}
    click visible element and wait until page contains element  ${claim_page_open_btn_locator}  ${claim_form_open_btn_locator}
    ${claim_open_form_answer_locator} =                         replace string  ${claim_open_form_answer_btn_locator_tpl}  %title%  ${complaintID}
    wait until page contains element with reloading             ${claim_open_form_answer_locator}
    ${claim_form_cancel_open_btn_locator} =                     replace string  ${claim_form_cancel_open_btn_locator_tpl}  %complaint_id%  ${complaintID}
    wait until page contains element with reloading             ${claim_form_cancel_open_btn_locator}
    open popup by btn locator                                   ${claim_form_cancel_open_btn_locator}
    capture page screenshot
    input text to exist visible input                           ${claim_form_cancellation_reason_input_locator}  ${cancellation_data.data.cancellationReason}
    capture page screenshot
    submit form and check result                                ${claim_form_complaintform_submit_btn_locator}  ${claim_cancel_submit_success_msg}  ${tender_created_checker_element_locator}

get claim information
    [Arguments]                                                 ${tender_uaid}  ${complaintID}  ${field_name}  ${award_index}=${None}
    [Documentation]                                             Отримати значення поля field_name скарги/вимоги complaintID про
    ...                                                         виправлення умов закупівлі/лоту для тендера tender_uaid (скарги/вимоги про
    ...                                                         виправлення визначення переможця під номером award_index, якщо award_index != None).

    open tender page by uaid                                    ${tender_uaid}
    click visible element                                       ${claim_page_open_btn_locator}
    capture page screenshot
    ${claim_open_form_answer_locator} =                         replace string  ${claim_open_form_answer_btn_locator_tpl}  %title%  ${complaintID}
    wait until page contains element with reloading             ${claim_open_form_answer_locator}  30m
    capture page screenshot

    ${claim_wrapper_complain_id_value_locator} =                set variable  ${claim_open_form_answer_locator}
#    ${claim_wrapper_complaint_id_value_locator} =               replace string  ${claim_wrapper_complain_id_value_locator_tpl}  %complain_id%  ${complaintID}
    ${claim_description_value_locator} =                        Run Keyword If  'description' == '${field_name}'   set variable  ${claim_wrapper_complain_id_value_locator} ${claim_description_value_locator}
    ${claim_title_value_locator} =                              Run Keyword If  'title' == '${field_name}'   set variable  ${claim_wrapper_complain_id_value_locator} ${claim_title_value_locator}
    ${claim_complain_id_value_locator} =                        Run Keyword If  'complaintID' == '${field_name}'   set variable  ${claim_wrapper_complain_id_value_locator} ${claim_complain_id_value_locator}
    ${claim_status_value_locator} =                             Run Keyword If  'status' == '${field_name}'   set variable  ${claim_wrapper_complain_id_value_locator} ${claim_status_value_locator}
    ${claim_resolution_type_value_locator} =                    Run Keyword If  'resolutionType' == '${field_name}'   set variable  ${claim_wrapper_complain_id_value_locator} ${claim_resolution_type_value_locator}
    ${claim_resolution_value_locator} =                         Run Keyword If  'resolution' == '${field_name}'   set variable  ${claim_wrapper_complain_id_value_locator} ${claim_resolution_value_locator}
    ${claim_satisfied_value_locator} =                          Run Keyword If  'satisfied' == '${field_name}'   set variable  ${claim_wrapper_complain_id_value_locator} ${claim_satisfied_value_locator}
    ${claim_related_lot_value_locator} =                        Run Keyword If  'relatedLot' == '${field_name}'   set variable  ${claim_wrapper_complain_id_value_locator} ${claim_related_lot_value_locator}
    ${claim_cancellation_reason_value_locator} =                Run Keyword If  'cancellationReason' == '${field_name}'   set variable  ${claim_wrapper_complain_id_value_locator} ${claim_cancellation_reason_value_locator}

    Run Keyword If                                              "${TEST_NAME}" == "Можливість відповісти на вимогу про виправлення умов закупівлі"    Wait Until Keyword Succeeds  420 s  15 s  Wait For Answered   ${complaintID}  ${claim_wrapper_complain_id_value_locator}
    Run Keyword If                                              "${TEST_NAME}" == "Можливість відповісти на вимогу про виправлення умов лоту"    Wait Until Keyword Succeeds  420 s  15 s  Wait For Answered   ${complaintID}  ${claim_wrapper_complain_id_value_locator}
    Run Keyword If                                              "Відображення статусу 'answered'" in "${TEST_NAME}"    Wait Until Keyword Succeeds  300 s  15 s  Wait For Answered   ${complaintID}  ${claim_wrapper_complain_id_value_locator}
    Run Keyword If                                              "${TEST_NAME}" == "Відображення задоволення вимоги"    Wait Until Keyword Succeeds  300 s  15 s  Wait For Satisfied   ${complaintID}  ${claim_wrapper_complain_id_value_locator}
    Run Keyword If                                              "${TEST_NAME}" == "Відображення незадоволення вимоги"    Wait Until Keyword Succeeds  300 s  15 s  Wait For Satisfied   ${complaintID}  ${claim_wrapper_complain_id_value_locator}
    Run Keyword If                                              "Відображення статусу 'resolved'" in "${TEST_NAME}"     Wait Until Keyword Succeeds  300 s  15 s  Wait For Resolved   ${complaintID}  ${claim_wrapper_complain_id_value_locator}
    Run Keyword If                                              "Відображення статусу 'cancelled'" in "${TEST_NAME}"    Wait Until Keyword Succeeds  300 s  15 s  Wait For Cancelled   ${complaintID}  ${claim_wrapper_complain_id_value_locator}
    Run Keyword If                                              "Відображення статусу 'ignored'" in "${TEST_NAME}"    Wait Until Keyword Succeeds  300 s  15 s  Wait For Ignored   ${complaintID}  ${claim_wrapper_complain_id_value_locator}
    Run Keyword If                                              "Відображення статусу 'stopping'" in "${TEST_NAME}"    Wait Until Keyword Succeeds  300 s  15 s  Wait For Stopping   ${complaintID}  ${claim_wrapper_complain_id_value_locator}
    Run Keyword If                                              "Відображення статусу 'pending'" in "${TEST_NAME}"    Wait Until Keyword Succeeds  300 s  15 s  Wait For Pending   ${complaintID}  ${claim_wrapper_complain_id_value_locator}
    Run Keyword And Ignore Error                                Run Keyword If    "Відображення кінцевих статусів двох останніх вимог" in "${TEST_NAME}"    Wait Until Keyword Succeeds  30 s  5 s  Wait For Invalid   ${complaintID}  ${claim_wrapper_complain_id_value_locator}
    Run Keyword And Ignore Error                                Run Keyword If    "Відображення кінцевих статусів двох останніх вимог" in "${TEST_NAME}"    Wait Until Keyword Succeeds  30 s  5 s  Wait For Declined   ${complaintID}  ${claim_wrapper_complain_id_value_locator}

    Run Keyword And Return If                                   'description' == '${field_name}'   get value by locator on opened page  ${claim_description_value_locator}
    Run Keyword And Return If                                   'complaintID' == '${field_name}'   get value by locator on opened page  ${claim_complain_id_value_locator}
    Run Keyword And Return If                                   'title' == '${field_name}'   get value by locator on opened page  ${claim_title_value_locator}
    Run Keyword And Return If                                   'status' == '${field_name}'   get value by locator on opened page  ${claim_status_value_locator}
    Run Keyword And Return If                                   'resolutionType' == '${field_name}'   get value by locator on opened page  ${claim_resolution_type_value_locator}
    Run Keyword And Return If                                   'resolution' == '${field_name}'   get value by locator on opened page  ${claim_resolution_value_locator}
    Run Keyword And Return If                                   'satisfied' == '${field_name}'   Отримати інформацію із скарги satisfied  ${claim_satisfied_value_locator}
    Run Keyword And Return If                                   'relatedLot' == '${field_name}'   get value by locator on opened page  ${claim_related_lot_value_locator}
    Run Keyword And Return If                                   'cancellationReason' == '${field_name}'   get value by locator on opened page  ${claim_cancellation_reason_value_locator}

Отримати інформацію із документа скарги title
    [Arguments]                                                 ${complaintID}  ${doc_id}
    [Documentation]                                             Отримати значення поля title з документу з doc_id в описі для скарги для тендера.

    click visible element                                       ${claim_page_open_btn_locator}
    ${claim_open_form_answer_locator} =                         replace string  ${claim_open_form_answer_btn_locator_tpl}  %title%  ${complaintID}
    wait until page contains element with reloading             ${claim_open_form_answer_locator}
    ${claim_file_name_input_locator} =                          replace string  ${claim_file_name_input_locator_tpl}  %complain_id%  ${complaintID}
#    wait until page contains element with reloading             ${claim_file_name_input_locator}

    ${return_value} =                                           get text  ${claim_file_name_input_locator}
    [return]                                                    ${return_value}

get document complaint
    [Arguments]                                                 ${complaintID}  ${doc_id}
    [Documentation]                                             Завантажити файл doc_id до скарги complaintID для тендера tender_uaid
    ...                                                         в директорію ${OUTPUT_DIR} для перевірки вмісту цього файлу.

    ${claim_file_name_input_locator} =                          replace string  ${claim_file_name_input_locator_tpl}  %complain_id%  ${complaintID}
    wait until page contains element with reloading             ${claim_file_name_input_locator}
    ${claim_file_link_input_locator} =                          replace string  ${claim_file_link_input_locator_tpl}  %complain_id%  ${complaintID}
    ${claim_file_name_input_locator} =                          replace string  ${claim_file_name_input_locator_tpl}  %complain_id%  ${complaintID}
    wait until page contains element with reloading             ${tender_new_doc_locator}

    ${file_link} =                                              Execute Javascript  ${claim_file_link_input_locator}
    ${file_name} =                                              get text  ${claim_file_name_input_locator}
    download_file  ${file_link}  ${file_name}  ${OUTPUT_DIR}
    [return]                                                    ${file_name}


Підтвердити вирішення вимоги
    [Arguments]                                                 ${username}  ${tender_uaid}  ${type}  ${type_id}  ${complaintID}  ${data}  ${award_index}
    [Documentation]                                             Підтвердити вирішення вимоги

    open tender page by uaid                                    ${tender_uaid}
    click visible element                                       ${claim_page_open_btn_locator}
    click visible element and wait until page contains element  ${claim_page_open_btn_locator}  ${claim_form_open_btn_locator}
    ${claim_form_resolved_input_locator} =                      replace string  ${claim_form_resolved_input_locator_tpl}  %complaint_id%  ${complaintID}
    open popup by btn locator                                   ${claim_form_resolved_input_locator}
    ${value} =                                                  Set Variable If  '${data.data.satisfied}'  Задоволен  Не задоволен
    run keyword and ignore error                                select from visible list by label  ${claim_form_satisfied_input_locator}  ${value}
    capture page screenshot
    submit form and check result                                ${claim_form_complaintform_submit_btn_locator}  ${claim_form_satisfied_submit_success_msg}  ${None}


Відповісти на вимогу
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}  ${award_index}
    [Documentation]                                             Відповісти на вимогу complaintID
    ...                                                         для тендера tender_uaid, використовуючи при цьому дані answer_data.

    open tender page by uaid                                    ${tender_uaid}
    click visible element                                       ${claim_page_open_btn_locator}
    ${claim_open_form_answer_locator} =                         replace string  ${claim_open_form_answer_btn_locator_tpl}  %title%  ${complaintID}
    wait until page contains element with reloading             ${claim_open_form_answer_locator}
    ${claim_form_open_form_answer_btn_locator} =                replace string  ${claim_form_open_form_answer_btn_locator_tpl}  %title%  ${complaintID}
    wait until page contains element with reloading             ${claim_form_open_form_answer_btn_locator}
    open popup by btn locator                                   ${claim_form_open_form_answer_btn_locator}
    input text to exist visible input                           ${claim_form_answer_resolution_value_locator}  ${answer_data.data.resolution}
    Run Keyword If                                              '${answer_data.data.resolutionType}' == 'resolved'  select from list by value  ${claim_form_answer_resolution_type_value_locator}  resolved
    Run Keyword If                                              '${answer_data.data.resolutionType}' == 'declined'  select from list by value  ${claim_form_answer_resolution_type_value_locator}  declined
    Run Keyword If                                              '${answer_data.data.resolutionType}' == 'invalid'  select from list by value  ${claim_form_answer_resolution_type_value_locator}  invalid
    Run Keyword And Ignore Error                                input text to exist visible input  ${claim_form_answer_tenderer_action_value_locator}  ${answer_data.data.tendererAction}
    submit form and check result                                ${claim_form_answer_success_btn_locator}  ${claim_form_answer_submit_success_msg}


Wait For Answered
    [Arguments]                                                 ${complaintID}  ${wrapper}
    [Documentation]                                             Очікування статусу Answered вимоги complaintID
    ...                                                         для тендера tender_uaid.

    Reload Page
    ${claim_form_status_locator} =                              replace string  ${claim_form_status_locator_tpl}  %query%  answered
    ${claim_status_value_locator} =                             set variable  ${wrapper} ${claim_form_status_locator}
    Page Should Contain Element                                 ${claim_status_value_locator}

Wait For Satisfied
    [Arguments]                                                 ${complaintID}  ${wrapper}
    [Documentation]                                             Очікування статусу Answered вимоги complaintID
    ...                                                         для тендера tender_uaid.

    Reload Page
    ${claim_form_satisfied_value_locator} =                     replace string  ${claim_form_satisfied_value_locator_tpl}  %query%  Так
    ${claim_form_satisfied_value_locator_tmp} =                 set variable  ${wrapper} ${claim_form_satisfied_value_locator}
    Page Should Contain Element                                 ${claim_form_satisfied_value_locator_tmp}

Wait For Resolved
    [Arguments]                                                 ${complaintID}  ${wrapper}
    [Documentation]                                             Очікування статусу Answered вимоги complaintID
    ...                                                         для тендера tender_uaid.

    Reload Page
    ${claim_form_resolved_value_locator} =                      replace string  ${claim_form_status_locator_tpl}  %query%  resolved
    ${claim_form_resolved_value_locator_tmp} =                  set variable  ${wrapper} ${claim_form_resolved_value_locator}
    Page Should Contain Element                                 ${claim_form_resolved_value_locator_tmp}

Wait For Cancelled
    [Arguments]                                                 ${complaintID}  ${wrapper}
    [Documentation]                                             Очікування статусу Answered вимоги complaintID
    ...                                                         для тендера tender_uaid.

    Reload Page
    ${claim_form_status_locator} =                              replace string  ${claim_form_status_locator_tpl}  %query%  cancelled
    ${claim_status_value_locator} =                             set variable  ${wrapper} ${claim_form_status_locator}
    Page Should Contain Element                                 ${claim_status_value_locator}

Wait For Ignored
    [Arguments]                                                 ${complaintID}  ${wrapper}
    [Documentation]                                             Очікування статусу Answered вимоги complaintID
    ...                                                         для тендера tender_uaid.

    Reload Page
    ${claim_form_status_locator} =                              replace string  ${claim_form_status_locator_tpl}  %query%  ignored
    ${claim_status_value_locator} =                             set variable  ${wrapper} ${claim_form_status_locator}
    Page Should Contain Element                                 ${claim_status_value_locator}

Wait For Stopping
    [Arguments]                                                 ${complaintID}  ${wrapper}
    [Documentation]                                             Очікування статусу Answered вимоги complaintID
    ...                                                         для тендера tender_uaid.

    Reload Page
    ${claim_form_status_locator} =                              replace string  ${claim_form_status_locator_tpl}  %query%  stopping
    ${claim_status_value_locator} =                             set variable  ${wrapper} ${claim_form_status_locator}
    Page Should Contain Element                                 ${claim_status_value_locator}

Wait For Pending
    [Arguments]                                                 ${complaintID}  ${wrapper}
    [Documentation]                                             Очікування статусу Pending вимоги complaintID
    ...                                                         для тендера tender_uaid.

    Reload Page
    ${claim_form_status_locator} =                              replace string  ${claim_form_status_locator_tpl}  %query%  pending
    ${claim_status_value_locator} =                             set variable  ${wrapper} ${claim_form_status_locator}
    Page Should Contain Element                                 ${claim_status_value_locator}

Отримати інформацію із скарги satisfied
    [Arguments]                                                 ${wrapper}
    [Documentation]                                             Отримати інформацію із скарги satisfied


    ${return_value} =                                           get value by locator on opened page  ${wrapper}
    ${return_value} =                                           Run Keyword If  'Так' == '${return_value}'  Set Variable  True
    ...                                                         ELSE Set Variable  False
    ${return_value} =                                           Convert To Boolean  ${return_value}
    [return]                                                    ${return_value}

Wait For Invalid
    [Arguments]                                                 ${complaintID}  ${wrapper}
    [Documentation]                                             Очікування статусу Invalid вимоги complaintID
    ...                                                         для тендера tender_uaid.

    Reload Page
    ${claim_form_status_locator} =                              replace string  ${claim_form_status_locator_tpl}  %query%  invalid
    ${claim_status_value_locator} =                             set variable  ${wrapper} ${claim_form_status_locator}
    Page Should Contain Element                                 ${claim_status_value_locator}

Wait For Declined
    [Arguments]                                                 ${complaintID}  ${wrapper}
    [Documentation]                                             Очікування статусу declined вимоги complaintID
    ...                                                         для тендера tender_uaid.

    Reload Page
    ${claim_form_status_locator} =                              replace string  ${claim_form_status_locator_tpl}  %query%  declined
    ${claim_status_value_locator} =                             set variable  ${wrapper} ${claim_form_status_locator}
    Page Should Contain Element                                 ${claim_status_value_locator}


