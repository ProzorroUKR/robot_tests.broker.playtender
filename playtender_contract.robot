*** Settings ***

Resource                                                        playtender_common.robot
Resource                                                        playtender_variables.robot
Resource                                                        playtender_contract_variables.robot
Resource                                                        playtender_qualification_variables.robot

*** Keywords ***

edit contract
    [Arguments]                                                 ${contract_index}  ${field_name}  ${amount}   ${field_name2}=${None}  ${amount2}=${None}
    [Documentation]                                             Редагувати контракт з індексом ${contract_index}
    ...                                                         для поля field_name та значення amount.

    Run Keyword If                                              '${TEST_NAME}' == 'Неможливість вказати ціну договору з ПДВ більше ніж результат проведення аукціону' and '${mode}' not in 'open_esco'  Fail   Amount should be less or equal to awarded amount
    Run Keyword If                                              '${TEST_NAME}' == 'Неможливість вказати ціну договору з ПДВ більше ніж результат проведення аукціону' and '${mode}' in 'open_esco'  Fail   Can't update amount for contract value
    Run Keyword If                                              '${TEST_NAME}' == 'Неможливість зменшити ціну договору без ПДВ на суму більшу за 20% від ціни договору з ПДВ (закупівля з ПДВ)'  Fail   Amount should be greater than amountNet and differ by no more than 20.0%
    click visible element                                       ${contract_form_0_open_btn_locator}
    Run Keyword And Ignore Error                                Wait Until Page Contains                                    ${contract_contractform_contract_number_input_locator}  10
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  5
    wait until element is visible                               ${contract_contractform_contract_number_input_locator}  10
    capture page screenshot
    ${file_path}  ${file_name}  ${file_content} =               create_fake_doc
    ${value_added_tax_included} =                               Run Keyword If  '${mode}' == 'negotiation'  run keyword and return status  Checkbox Should Not Be Selected  ${contract_contractform_value_added_tax_included_locator}
    run keyword if                                              '${mode}' == 'negotiation' and ${value_added_tax_included}  click visible element  ${contract_contractform_value_added_tax_included_locator}
    ${contract_number} =                                        get value by locator on opened page  ${contract_contractform_contract_number_input_locator}
    Run Keyword If                                              '${contract_number}' == ''  input text to exist visible input  ${contract_contractform_contract_number_input_locator}  1234567890
    capture page screenshot
    ${date_signed} =                                            Get Current Date
    ${contract_date_signed} =                                   get value by locator on opened page  ${contract_contractform_date_signed_input_locator}
    Run Keyword If                                              '${contract_date_signed}' == ''  input datetime to visible input  ${contract_contractform_date_signed_input_locator}  ${date_signed}
    ${date_start} =                                             Get Current Date  increment=02:00:00
    ${contract_date_start} =                                    get value by locator on opened page  ${contract_contractform_date_start_input_locator}
    Run Keyword If                                              '${contract_date_start}' == ''  input datetime to visible input  ${contract_contractform_date_start_input_locator}  ${date_start}
    ${date_end} =                                               Get Current Date  increment=04:00:00
    ${contract_date_end} =                                      get value by locator on opened page  ${contract_contractform_date_end_input_locator}
    Run Keyword If                                              '${contract_date_end}' == ''  input datetime to visible input  ${contract_contractform_date_end_input_locator}  ${date_end}

    Run Keyword If                                              '${field_name}' == 'value.amount'  input number to exist visible input  ${contract_contractform_amount_input_locator}  ${amount}
#    ${budget} =                                                 Run Keyword If  '${field_name}' == 'value.amount' and '${mode}' == 'negotiation'  Set Variable  ${amount/0.85}
#    Run Keyword If                                              '${field_name}' == 'value.amount' and '${mode}' == 'negotiation'  input number to exist visible input  ${contract_contractform_amount_input_locator}  ${budget}
    Run Keyword If                                              '${field_name}' == 'value.amountNet'  input number to exist visible input  ${contract_contractform_amount_net_input_locator}  ${amount}
    capture page screenshot
    choose file                                                 ${add_file_to_contract_contractform_locator}  ${file_path}
    wait until page does not contain element                    ${popup_dynamic_form_loading_element_locator}  60
    wait until element is visible                               ${contract_contractform_add_document_type_input_locator}  60
    capture page screenshot
    Run Keyword And Ignore Error                                Execute Javascript  $('.fancybox-is-open .fancybox-content select[id*="-document_type"]:last').val('contractSigned').change()
    capture page screenshot
    click visible element                                       ${contract_contractform_add_document_description_btn_locator}
    capture page screenshot
    wait until element is visible                               ${contract_contractform_add_document_description_input_locator}
    input text to exist visible input                           ${contract_contractform_add_document_description_input_locator}  test2
    capture page screenshot
    click visible element                                       ${contract_contractform_add_document_close_description_btn_locator}
    capture page screenshot

    submit form and check result                                ${contract_contractform_submit_btn_locator}  ${contract_contractform_submit_success_msg}  ${contract_active_form_open_btn_locator}
#    run keyword and ignore error                                submit form and check result  ${contract_contractform_submit_btn_locator}  ${contract_contractform_submit_success_msg}  ${contract_active_form_open_btn_locator}
    capture page screenshot

edit unitprices
    [Arguments]                                                 ${tender_uaid}  ${contract_data}
    [Documentation]                                             Встановити ціну за одиницю для контракту для користувача username для тендера ${tender_uaid},
    ...                                                         використовуючи значення з ${contract_data}.

#    Run Keyword If                                              '${TEST_NAME}' == 'Можливість встановити ціну за одиницю для першого контракту'  open popup by btn locator  ${contract_active_form_agreement_open_btn_locator}
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість встановити ціну за одиницю для другого контракту'  click visible element  ${contract_next_form_agreement_open_btn_locator}
#    Run Keyword If                                              '${TEST_NAME}' == 'Можливість встановити ціну за одиницю для другого контракту'  open popup by btn locator  ${contract_active_form_agreement_open_btn_locator}
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість встановити ціну за одиницю для третього контракту'  click visible element  ${contract_next_form_agreement_open_btn_locator}
    open popup by btn locator                                   ${contract_active_form_agreement_open_btn_locator}
    input number to exist visible input                         ${contract_agreement_unit_prices_input_locator}  ${contract_data.data.unitPrices.value.amount}

    submit form and check result                                ${contract_contractform_submit_btn_locator}  ${contract_agreement_active_submit_success_msg}
    capture page screenshot

active agreement contract
    [Arguments]                                                 ${startDate}  ${endDate}
    [Documentation]                                             Зареєструвати угоду для користувача username для тендера tender_uaid,
    ...                                                         для поля Початок строку, на який укладається угода задати значення startDate, для Кінець строку, на який укладається угода - endDate.

    open popup by btn locator                                   ${contract_active_agreement_form_open_btn_locator}
    capture page screenshot
    ${file_path}  ${file_name}  ${file_content} =               create_fake_doc
    ${contract_number} =                                        get value by locator on opened page  ${contract_agreement_agreement_number_input_locator}
    Run Keyword If                                              '${contract_number}' == ''  input text to exist visible input  ${contract_agreement_agreement_number_input_locator}  1234567890
    capture page screenshot
    ${date_signed} =                                            Get Current Date
    ${contract_date_signed} =                                   get value by locator on opened page  ${contract_agreement_date_signed_input_locator}
    Run Keyword If                                              '${contract_date_signed}' == ''  input datetime to visible input  ${contract_agreement_date_signed_input_locator}  ${date_signed}
    ${date_start} =                                             Get Current Date  increment=02:00:00
    ${contract_date_start} =                                    get value by locator on opened page  ${contract_agreement_date_start_input_locator}
    Run Keyword If                                              '${contract_date_start}' == ''  input datetime to visible input  ${contract_agreement_date_start_input_locator}  ${date_start}
    ${date_end} =                                               Get Current Date  increment=04:00:00
    ${contract_date_end} =                                      get value by locator on opened page  ${contract_agreement_date_end_input_locator}
    Run Keyword If                                              '${contract_date_end}' == ''  input datetime to visible input  ${contract_agreement_date_end_input_locator}  ${date_end}

    capture page screenshot
    choose file                                                 ${add_file_to_contract_contractform_locator}  ${file_path}
    wait until page does not contain element                    ${popup_dynamic_form_loading_element_locator}  60
    wait until element is visible                               ${contract_contractform_add_document_type_input_locator}  60
    capture page screenshot
    Run Keyword And Ignore Error                                Execute Javascript  $('.fancybox-is-open .fancybox-content select[id*="-document_type"]:last').val('contractSigned').change()
    capture page screenshot
    click visible element                                       ${contract_contractform_add_document_description_btn_locator}
    capture page screenshot
    wait until element is visible                               ${contract_contractform_add_document_description_input_locator}
    input text to exist visible input                           ${contract_contractform_add_document_description_input_locator}  test2
    capture page screenshot
    click visible element                                       ${contract_contractform_add_document_close_description_btn_locator}
    capture page screenshot

    submit form and check result                                ${contract_contractform_submit_btn_locator}  ${contract_agreement_submit_success_msg}
    capture page screenshot
    open popup by btn locator                                   ${contract_active_agreement_active_form_open_btn_locator}
    Execute Javascript  $('.fancybox-is-open .fancybox-content button.btn.btn-success').click()
    capture page screenshot
    run keyword and ignore error                                Load Sign
    capture page screenshot
    submit form and check result                                ${qualification_form_submit_btn_locator}  ${contract_agreement_active_submit_success_msg}  ${None}
    capture page screenshot

