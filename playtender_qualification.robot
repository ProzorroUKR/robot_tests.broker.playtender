*** Settings ***

Resource                                                        playtender_common.robot
Resource                                                        playtender_variables.robot
Resource                                                        playtender_bid_variables.robot
Resource                                                        playtender_qualification_variables.robot

*** Keywords ***


open tender form prequalification
    [Arguments]                                                 ${qualification_num}
    [Documentation]                                             Відкрити форму прекваліфікації і потрібну кваліфікацію під номером qualification_num

    run keyword if                                              ${qualification_num} == 0  wait until page contains element with reloading  ${prequalification_form_0_open_btn_locator}
    run keyword if                                              ${qualification_num} == 0  open popup by btn locator  ${prequalification_form_0_open_btn_locator}
    run keyword if                                              ${qualification_num} == 1  open popup by btn locator  ${prequalification_form_1_open_btn_locator}
    run keyword if                                              ${qualification_num} == -1  open popup by btn locator  ${prequalification_form_-1_open_btn_locator}
    run keyword if                                              ${qualification_num} == -2  wait until page contains element with reloading  ${prequalification_form_-2_open_btn_locator}
    run keyword if                                              ${qualification_num} == -2  open popup by btn locator  ${prequalification_form_-2_open_btn_locator}
#    run keyword if                                              ${qualification_num} == -2  execute javascript  $('#bids-pjax .pseudo-table__row:last a[href*="/tender/prequalification"]').click()

confirm qualifications
    [Documentation]                                             Відкрити форму прекваліфікації і перевести кваліфікацію під номером qualification_num до тендера
    ...                                                         tender_uaid в статус active.

    Execute Javascript  $('#prequalificationform-decision').val('accept').change()
    capture page screenshot
    wait until page contains element                            ${prequalification_form_eligible_input_locator}
    capture page screenshot
    click visible element                                       ${prequalification_form_eligible_input_locator}
    click visible element                                       ${prequalification_form_qualified_input_locator}
    submit form and check result                                ${qualification_form_submit_btn_locator}  ${qualification_form_submit_success_msg}  ${tender_created_checker_element_locator}

reject qualifications
    [Documentation]                                             Відкрити форму прекваліфікації і перевестикваліфікацію під номером qualification_num до тендера
    ...                                                         tender_uaid в статус unsuccessful.

    Execute Javascript  $('#prequalificationform-decision').val('decline').change()
    capture page screenshot
    wait until page contains element                            ${qualification_form_reasons_cancellation_input_locator}
    capture page screenshot
    input text to exist visible input                           ${qualification_form_reasons_cancellation_input_locator}  GenerateFakeText
    Execute Javascript  ${prequalification_form_title_cancellation_input_locator}
    capture page screenshot
#    input text to exist visible input                           ${qualification_form_reasons_cancellation_input_locator}  GenerateFakeText
    input text to exist visible input                           ${prequalification_form_description_cancellation_input_locator}  GenerateFakeText
    capture page screenshot
    submit form and check result                                ${qualification_form_submit_btn_locator}  ${qualification_form_decline_success_msg}  ${tender_created_checker_element_locator}
    capture page screenshot

cancel qualifications
    [Documentation]                                             Відкрити форму прекваліфікації і перевести кваліфікацію під номером qualification_num до тендера
    ...                                                         tender_uaid в статус cancelled.

    wait until page contains element                            ${prequalification_form_description_cancellation_input_locator}
    Execute Javascript  $('#prequalificationform-decision').val('cancel').change()
#    select from visible list by label  ${tender_form_award_organization_region_id_locator}  ${region}
    capture page screenshot
    wait until page contains element                            ${prequalification_form_description_cancellation_input_locator}
    capture page screenshot
    input text to exist visible input                           ${prequalification_form_description_cancellation_input_locator}  GenerateFakeText
    capture page screenshot
    submit form and check result                                ${qualification_form_submit_btn_locator}  ${qualification_form_cancel_success_msg}  ${tender_created_checker_element_locator}

approve the final qualification decision
    [Documentation]                                             Перевести тендер tender_uaid в статус active.pre-qualification.stand-still.

    wait until page contains                                    ${qualification_form_approve_question_msg}
    Execute Javascript  ${qualification_form_approve_js_submit_btn_locator}
    Wait Until Page Contains                                    ${qualification_form_approve_success_msg}  60
    wait until alert is visible                                 ${qualification_form_approve_success_msg}
    run keyword and ignore error                                run keyword if condition is not none  ${qualification_form_approve_success_msg}  close current visible alert
    Wait Until Keyword Succeeds                                 1600 s    20 s    Wait For QualificationsPeriodEnd

#qualification
open tender form qualification
    [Arguments]                                                 ${award_num}
    [Documentation]                                             Відкрити форму кваліфікації і потрібну кваліфікацію під номером award_num

    run keyword if                                              "${mode}" not in "open_framework"  Run Keywords
    ...                                                         run keyword if  ${award_num} == 0  wait until page contains element with reloading  ${qualification_form_0_open_btn_locator}
    ...  AND                                                    run keyword if  ${award_num} == 0  open popup by btn locator  ${qualification_form_0_open_btn_locator}
##### BOF - TMP #####
    ...  AND                                                    run keyword if  ${award_num} == 1  open popup by btn locator  ${qualification_form_1_open_btn_locator}
    ...  AND                                                    run keyword if  ${award_num} == -1  open popup by btn locator  ${qualification_form_last_open_btn_locator}
    ...  AND                                                    run keyword if  ${award_num} == 2  open popup by btn locator  ${qualification_form_2_open_btn_locator}
    ...  ELSE IF                                                "${mode}" in "open_framework"  Run Keywords
    ...                                                         run keyword if  ${award_num} == 0  wait until page contains element with reloading  ${qualification_form_0_open_btn_locator}
    ...  AND                                                    run keyword if  ${award_num} == 0  open popup by btn locator  ${qualification_form_0_open_btn_locator}
    ...  AND                                                    run keyword if  ${award_num} == 1  open popup by btn locator  ${qualification_form_1_open_btn_locator}
    ...  AND                                                    run keyword if  ${award_num} == -1  open popup by btn locator  ${qualification_form_last_open_btn_locator}
    ...  AND                                                    run keyword if  ${award_num} == 2  open popup by btn locator  ${qualification_form_2_open_btn_locator}
    ...  AND                                                    run keyword if  ${award_num} == 3  open popup by btn locator  ${qualification_form_3_open_btn_locator}

copy file qualification
    [Arguments]                                                 ${username}  ${document}  ${award_num}
    [Documentation]                                             Завантажити документ, який знаходиться по шляху document до
    ...                                                         постачальника під номером award_num для тендера tender_uaid.

    ## copy file to another dir to prevent it deleting
    ${new_doc_name} =                                           Replace String  ${document}  /tmp/  /tmp/playtender/
    Copy File                                                   ${document}  ${new_doc_name}
    Set To Dictionary                                           ${USERS.users['${username}']}  qproposal${award_num}_document=${new_doc_name}

confirm award qualification
    [Arguments]                                                 ${username}  ${award_num}
    [Documentation]                                             Перевести постачальника під номером award_num для тендера tender_uaid
    ...                                                         в статус active.

    Wait Until Page Contains                                    ${popup_opened_content_success_locator}  60
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  10
    wait until element is visible                               ${qualification_form_submit_btn_locator}  60
#    ${doc_isset}=  GetDictionaryKeyExist  ${USERS.users['${username}']}  qproposal${award_num}_document
#    ${doc_name}=  Run Keyword If  ${doc_isset}  GetValueFromDictionaryByKey  ${USERS.users['${username}']}  qproposal${award_num}_document
#    ...  ELSE  create_fake_doc
    ${file_path}  ${file_name}  ${file_content} =               create_fake_doc
#    Execute Javascript                                          ${qualification_form_accept_input_locator}
    Execute Javascript  $('#qualificationform-decision').val('accept').change()
#    select from visible list by label  ${tender_form_award_organization_region_id_locator}  ${region}
    capture page screenshot
    run keyword and ignore error                                wait until page contains element  ${qualification_form_eligible_input_locator}
    capture page screenshot
    run keyword and ignore error                                click visible element  ${qualification_form_eligible_input_locator}
    run keyword and ignore error                                click visible element  ${qualification_form_qualified_input_locator}
    choose file                                                 ${add_file_to_qualification_form_locator}  ${file_path}
    wait until page does not contain element                    ${popup_dynamic_form_loading_element_locator}  60
    wait until element is visible                               ${qualification_form_add_document_type_input_locator}  60
#    submit current visible popup

    Run Keyword And Ignore Error                                Execute Javascript  $('.fancybox-is-open .fancybox-content select[id*="-document_type"]:last').val('winningBid').change()
    capture page screenshot
    click visible element                                       ${qualification_form_add_document_description_btn_locator}
    capture page screenshot
    wait until element is visible                               ${qualification_form_add_document_description_input_locator}
    input text to exist visible input                           ${qualification_form_add_document_description_input_locator}  test2
    capture page screenshot
    click visible element                                       ${qualification_form_add_document_close_description_btn_locator}
    capture page screenshot

    run keyword and ignore error                                click visible element  ${qualification_ecp_check_input_locator}
    capture page screenshot
    run keyword and ignore error                                submit form and check result  ${qualification_form_submit_btn_locator}  ${qualification_award_form_submit_success_msg}  ${qualification_form_submit_btn_locator}
    capture page screenshot
    wait until element is visible                               ${qualification_form_submit_btn_locator}  60
##    run keyword and ignore error                                submit form and check result  ${qualification_form_submit_btn_locator}  ${None}  ${qualification_ecp_form_open_locator}
    Execute Javascript  $('.fancybox-is-open .fancybox-content button.btn.btn-success').click()
#    click visible element                                       ${qualification_form_submit_btn_locator}
    capture page screenshot
    wait until element is visible                               ${qualification_form_submit_btn_locator}  60
    wait until element is visible                               ${qualification_ecp_form_open_locator}  60
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  10
    capture page screenshot
    run keyword and ignore error                                Load Sign
    capture page screenshot
    wait until element is visible                               ${qualification_form_submit_btn_locator}  60
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  10
    capture page screenshot
    run keyword and ignore error                                submit form and check result  ${qualification_form_submit_btn_locator}  ${qualification_award_after_ecp_form_submit_success_msg}  ${None}
    capture page screenshot
#    Wait Until Page Contains                                    ЕЦП/КЕП успішно накладено на рішення, тепер потрібно підтвердити рішення.  60
#    click visible element                                       xpath=//div[contains(@class, 'jconfirm')]//*[text()='Закрити']


reject award qualification
    [Arguments]                                                 ${username}  ${award_num}
    [Documentation]                                             Перевести постачальника під номером award_num для тендера tender_uaid
    ...                                                         в статус active.

    Wait Until Page Contains                                    ${popup_opened_content_success_locator}  60
    wait until element is visible                               ${qualification_form_submit_btn_locator}  60
#    wait until popup is visible
    ${doc_isset} =                                              GetDictionaryKeyExist  ${USERS.users['${username}']}  qproposal${award_num}_document
#    ${doc_name} =                                               Run Keyword If  ${doc_isset}  GetValueFromDictionaryByKey  ${USERS.users['${username}']}  qproposal${award_num}_document
#    ...                                                         ELSE  GenerateFakeDocument
    ${file_path}  ${file_name}  ${file_content} =               create_fake_doc
    Execute Javascript  $('#qualificationform-decision').val('decline').change()
    capture page screenshot
#    select from visible list by label  ${tender_form_award_organization_region_id_locator}  ${region}
    wait until page contains element                            ${qualification_form_reasons_cancellation_input_locator}
    capture page screenshot
    Execute Javascript  ${qualification_award_form_title_cancellation_input_locator}
    capture page screenshot
#    input text to exist visible input                           ${qualification_form_reasons_cancellation_input_locator}  GenerateFakeText
    input text to exist visible input                           ${qualification_form_description_cancellation_input_locator}  GenerateFakeText

    choose file                                                 ${add_file_to_qualification_form_locator}  ${file_path}
    wait until element is visible                               ${qualification_form_add_document_type_input_locator}
#    submit current visible popup

    Run Keyword And Ignore Error  Execute Javascript  $('.fancybox-is-open .fancybox-content .field-bidform-documents select[id*="-document_type"]:last').val('winningBid').change()
    capture page screenshot
    click visible element                                       ${qualification_form_add_document_description_btn_locator}
    wait until element is visible                               ${qualification_form_add_document_description_input_locator}
    input text to exist visible input                           ${qualification_form_add_document_description_input_locator}  test2
    click visible element                                       ${qualification_form_add_document_close_description_btn_locator}

    submit form and check result                                ${qualification_form_submit_btn_locator}  ${qualification_form_cancell_success_msg}  ${tender_created_checker_element_locator}
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  10
    capture page screenshot
    run keyword and ignore error                                Load Sign
    capture page screenshot
    wait until element is visible                               ${qualification_form_submit_btn_locator}  60
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  10
    capture page screenshot
    run keyword and ignore error                                submit form and check result  ${qualification_form_submit_btn_locator}  ${qualification_award_after_ecp_form_submit_success_msg}  ${None}
    capture page screenshot
    reload page

cancel award qualification
    [Documentation]                                             Відкрити форму кваліфікації і перевести кваліфікацію під номером qualification_num до тендера
    ...                                                         tender_uaid в статус cancelled.

    wait until element is visible                               ${qualification_form_submit_btn_locator}  60
#    Execute Javascript                                          ${qualification_form_cancel_input_locator}
    Execute Javascript  $('#qualificationform-decision').val('cancel').change()
#    select from visible list by label  ${tender_form_award_organization_region_id_locator}  ${region}
    capture page screenshot
    run keyword and ignore error                                wait until page contains element                            ${qualification_form_description_cancellation_input_locator}
    capture page screenshot
    run keyword and ignore error                                Execute Javascript  ${qualification_award_form_title_decline_input_locator}
    run keyword and ignore error                                input text to exist visible input                           ${qualification_form_description_cancellation_input_locator}  GenerateFakeText
    capture page screenshot
    submit form and check result                                ${qualification_form_submit_btn_locator}  ${qualification_form_cancel_success_msg}  ${tender_created_checker_element_locator}

#qualification awawd reporting and negotiotion
confirm award
    [Arguments]                                                 ${document}
    [Documentation]                                             Перевести постачальника в статус active.

    run keyword and ignore error                                run keyword if  '${mode}' in 'negotiation reporting'  Wait Until Page Contains  ${award_form_negotiation_submit_success_msg}  60
    run keyword and ignore error                                run keyword if  '${mode}' in 'negotiation reporting'  wait until alert is visible  ${award_form_negotiation_submit_success_msg}
    run keyword and ignore error                                run keyword if  '${mode}' in 'negotiation reporting'  close current visible alert

    capture page screenshot
    wait until page contains element with reloading             ${qualification_form_0_open_btn_locator}
    click visible element                                       ${qualification_form_0_open_btn_locator}
    Wait Until Page Contains                                    ${popup_opened_content_success_locator}  60
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  10
    wait until element is visible                               ${qualification_form_submit_btn_locator}  60
#    ${file_path}  ${file_name}  ${file_content} =               create_fake_doc
    Execute Javascript  $('#qualificationform-decision').val('accept').change()
    capture page screenshot
    run keyword and ignore error                                wait until page contains element  ${award_form_qualified_input_locator}
    capture page screenshot
    run keyword and ignore error                                click visible element  ${award_form_qualified_input_locator}
    choose file                                                 ${add_file_to_qualification_form_locator}  ${document}
    wait until page does not contain element                    ${popup_dynamic_form_loading_element_locator}  60
    wait until element is visible                               ${qualification_form_add_document_type_input_locator}  60
#    submit current visible popup

    Run Keyword And Ignore Error                                Execute Javascript  $('.fancybox-is-open .fancybox-content select[id*="-document_type"]:last').val('winningBid').change()
    capture page screenshot
    click visible element                                       ${qualification_form_add_document_description_btn_locator}
    capture page screenshot
    wait until element is visible                               ${qualification_form_add_document_description_input_locator}
    input text to exist visible input                           ${qualification_form_add_document_description_input_locator}  test2
    capture page screenshot
    click visible element                                       ${qualification_form_add_document_close_description_btn_locator}
    capture page screenshot

    run keyword and ignore error                                click visible element  ${qualification_ecp_check_input_locator}
    capture page screenshot
    run keyword and ignore error                                run keyword if  '${mode}' in 'reporting'  submit form and check result  ${qualification_form_submit_btn_locator}  ${qualification_form_submit_success_msg}
    capture page screenshot
    run keyword and ignore error                                run keyword if  '${mode}' in 'reporting'   wait until page contains element with reloading  ${qualification_form_0_open_btn_locator}
    capture page screenshot
    run keyword and ignore error                                run keyword if  '${mode}' in 'reporting'   click visible element  ${qualification_form_0_open_btn_locator}
    capture page screenshot
    run keyword and ignore error                                run keyword if  '${mode}' in 'reporting'   Execute Javascript  $('#qualificationform-decision').val('accept').change()
    capture page screenshot
    run keyword and ignore error                                submit form and check result  ${qualification_form_submit_btn_locator}  ${qualification_award_form_submit_success_msg}  ${qualification_form_submit_btn_locator}
    capture page screenshot
    wait until element is visible                               ${qualification_form_submit_btn_locator}  60
##    run keyword and ignore error                                submit form and check result  ${qualification_form_submit_btn_locator}  ${None}  ${qualification_ecp_form_open_locator}
    Execute Javascript  $('.fancybox-is-open .fancybox-content button.btn.btn-success').click()
#    click visible element                                       ${qualification_form_submit_btn_locator}
    capture page screenshot
    wait until element is visible                               ${qualification_form_submit_btn_locator}  60
    wait until element is visible                               ${qualification_ecp_form_open_locator}  60
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  10
    capture page screenshot
    run keyword and ignore error                                Load Sign
    capture page screenshot
    wait until element is visible                               ${qualification_form_submit_btn_locator}  60
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  10
    capture page screenshot
    run keyword and ignore error                                submit form and check result  ${qualification_form_submit_btn_locator}  ${qualification_award_after_ecp_form_submit_success_msg}  ${None}
    capture page screenshot

confirm awards
    [Documentation]                                             Перевести постачальників для тендера tender_uaid
    ...                                                         в статус active.

    wait until page contains element with reloading             ${qualification_agreement_form_approve_submit_btn_locator}  720  30
    click visible element                                       ${qualification_agreement_form_approve_submit_btn_locator}
    wait until page contains                                    ${qualification_agreement_form_approve_question_msg}
    Execute Javascript  ${qualification_form_approve_js_submit_btn_locator}
    Wait Until Page Contains                                    ${qualification_agreement_form_approve_success_msg}  60
    wait until alert is visible                                 ${qualification_agreement_form_approve_success_msg}
    run keyword and ignore error                                run keyword if condition is not none  ${qualification_agreement_form_approve_success_msg}  close current visible alert
    Wait Until Keyword Succeeds                                 800 s    20 s    Wait For QualificationsPeriodEnd


