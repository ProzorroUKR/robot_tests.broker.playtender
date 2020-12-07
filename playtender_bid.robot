*** Settings ***

Resource                                                        playtender_common.robot
Resource                                                        playtender_variables.robot
Resource                                                        playtender_bid_variables.robot

*** Keywords ***


fill bid form
    [Arguments]                                                 ${tender_uaid}  ${bid}  ${lots_ids}  ${features_ids}
    [Documentation]                                             Подати цінову пропозицію bid для тендера tender_uaid на лоти lots_ids (якщо lots_ids != None) з неціновими показниками features_ids (якщо features_ids != None).

    submit form and check result                                ${bid_form_refresh_btn_locator}  ${bid_form_refresh_success_msg}  ${tender_created_checker_element_locator}  ${true}
    open popup by btn locator                                   ${bid_form_open_btn_locator}  ${bid_popup_locator}
    ${value} =                                                  get from dictionary by keys  ${bid.data}  value  amount
#    ${amount} =                                                 run keyword if condition is not none  ${value}  convert_float_to_string  ${bid.data.value.amount}
    run keyword if condition is not none                        ${value}  input number to exist visible input   ${bid_form_value_amount_input_locator}  ${value}
    capture page screenshot
#    ${lots} =                                                   get from dictionary by keys  ${data}  lots
    run keyword if condition is not none                        ${lots_ids}  fill bid form lots  ${bid}  ${lots_ids}  ${features_ids}
    capture page screenshot
#    run keyword if condition is none                            ${lots_ids}  fill bid form whithout lots  ${bid}
#    ${features} =                                               get from dictionary by keys  ${data}  features
#    run keyword if condition is not none                        ${features_ids}  fill bid form features  ${bid}  ${tender_form_general_panel_add_feature_btn_locator}
    fill bid required documents_all
    capture page screenshot
##    submit form and check result                                ${bid_form_submit_btn_locator}  ${bid_form_submit_success_msg}  ${tender_created_checker_element_locator}

fill bid form lots
    [Arguments]                                                 ${bid}  ${lots_ids}=${None}  ${features_ids}=${None}
    [Documentation]                                             Заповнити лотову цінову пропозицію bid для тендера tender_uaid на лоти lots_ids з неціновими показниками features_ids (якщо features_ids != None).

    ${lots} =                                                   get from dictionary by keys  ${bid.data}  lotValues
    ${lots_length} =                                            Get Length  ${lots}
    : FOR  ${INDEX}  IN RANGE  0  ${lots_length}
    \  Run Keyword And Ignore Error                             run keyword if condition is not none  ${lots}  input number to exist visible input   ${bid_form_value_amount_input_locator}  ${lots[${INDEX}].value.amount}
    \  capture page screenshot
    \  ${self_qualified} =                                      get from dictionary by keys  ${bid.data}  selfQualified
#    \  run keyword if condition is not none                     ${self_qualified}  click visible element  ${bid_form_value_self_qualified_input_locator}
    \  run keyword if condition is not none                     ${self_qualified}  execute javascript    $('.fancybox-is-open .fancybox-content input[id*="-self_qualified"]').click()
    \  capture page screenshot
    \  ${self_eligible} =                                       get from dictionary by keys  ${bid.data}  selfEligible
#    \  run keyword if condition is not none                     ${self_eligible}  click visible element  ${bid_form_value_self_eligible_input_locator}
    \  run keyword if condition is not none                     ${self_eligible}  execute javascript     $('.fancybox-is-open .fancybox-content input[id*="-self_eligible"]').click()
    \  capture page screenshot
    \  ${feature_id} =                                          get from dictionary by keys  ${bid.data}  parameters
    \  run keyword if condition is not none                     ${feature_id}  fill bid form features  ${feature_id}
    \  capture page screenshot
    \  run keyword if                                           '${mode}' in 'open_esco'  fill bid form lots Esco  ${bid.data.lotValues}

fill bid form features
    [Arguments]                                                 ${bid_parameters}
    [Documentation]                                             Заповнити нецінові показники цінової пропозиції.

    log many  ${bid_parameters}
    ${features_length} =                                        Get Length  ${bid_parameters}
    : FOR  ${INDEX}  IN RANGE  0  ${features_length}
    \  ${bid_form_feature_input_locator}                        replace string  ${bid_form_feature_input_locator_tpl}  %title%  ${bid_parameters[${INDEX}]['code']}
    \  ${bid_form_get_feature_input_locator}                    replace string  ${bid_form_get_feature_input_locator_tpl}  %title%  ${bid_parameters[${INDEX}]['code']}
    \  ${bid_form_feature_input_locator_select}                 replace string  ${bid_form_feature_input_locator_select_tpl}  %title%  ${bid_parameters[${INDEX}]['code']}
    \  ${value_enum} =                                          convert float to string  ${bid_parameters[${INDEX}]['value']}
    \  ${bid_form_feature_value_input_locator}                  set variable  ${bid_form_feature_input_locator} ${bid_form_feature_value_input_locator_tpl}
    \  ${bid_form_get_feature_value_input_locator}              set variable  ${bid_form_get_feature_input_locator} ${bid_form_get_feature_value_input_locator_tpl}
    \  ${bid_form_feature_value_input_locator}                  replace string  ${bid_form_feature_value_input_locator}  _  ' '
    \  ${bid_form_get_feature_value_input_locator}              replace string  ${bid_form_get_feature_value_input_locator}  _  ' '
    \  ${bid_form_feature_value_input_locator}                  replace string  ${bid_form_feature_value_input_locator}  %value%  ${value_enum}
    \  ${bid_form_get_feature_value_input_locator}              replace string  ${bid_form_get_feature_value_input_locator}  %value%  ${value_enum}
    \  ${enum_val}                                              set variable  ${bid_form_get_feature_value_input_locator}
    \  ${enum_val1}=                                            run keyword if  ${bid_parameters[${INDEX}]['value']} == 0  Execute Javascript   return $('[data-weight-source="0"]').text()
    \  ...  ELSE                                                Execute Javascript    ${enum_val}
    \  capture page screenshot
    \  Run Keyword And Ignore Error                             select from list by label  ${bid_form_feature_input_locator_select}  ${enum_val1}
    \  capture page screenshot

fill bid form lots Esco
    [Arguments]                                                 ${values}
    [Documentation]                                             Заповнити цінову пропозицію Esco

    log many  ${values}
    ${values_length} =                                          Get Length  ${values}
    : FOR  ${INDEX}  IN RANGE  0  ${values_length}
    \  input number to exist visible input                      ${bid_form_value_yearly_payments_percentage_input_locator}  ${values[${INDEX}].value.yearlyPaymentsPercentage}
    \  capture page screenshot
    \  input text to exist visible input                        ${bid_form_value_contract_duration_years_input_locator}  ${values[${INDEX}].value.contractDuration.years}
    \  capture page screenshot
    \  input text to exist visible input                        ${bid_form_value_contract_duration_days_input_locator}  ${values[${INDEX}].value.contractDuration.days}
    \  capture page screenshot
    \  fill bid form lots Esco AnnualCostsReduction             ${values[${INDEX}].value.annualCostsReduction}
    \  capture page screenshot

fill bid form lots Esco AnnualCostsReduction
    [Arguments]                                                 ${values}
    [Documentation]                                             Заповнити цінову пропозицію Esco (параметр AnnualCostsReduction).

    ${input_index} =                                            set variable  1
    : FOR  ${value}  IN  @{values}
    \  ${input_index_tmp}=  convert to string  ${input_index}
    \  ${bid_form_value_annual_costs_reduction_input_locator}  replace string  ${bid_form_value_annual_costs_reduction_input_locator_tpl}  %index%  ${input_index_tmp}
    \  input number to exist visible input                     ${bid_form_value_annual_costs_reduction_input_locator}  ${value}
    \  ${input_index} =                                        evaluate  ${input_index} + 1

fill bid required documents_all
    [Arguments]
    [Documentation]                                             Додати фейковий документ до цінової пропозиції при створенні.

    ${file_path}  ${file_name}  ${file_content} =               create_fake_doc
#    click visible element and wait until page contains element   ${open_form_add_doc_lot_btn_locator}   jquery=.modal.modal-form.js-form-popup.fancybox-content
    #click visible element                                       ${bid_form_add_document_all_btn_locator}
    capture page screenshot
###    execute javascript                                          $('.fancybox-is-open .fancybox-content .field-bidform-documents .js-upload-documents input[type$="file"]:first').click()
    capture page screenshot
    choose file                                                 ${add_file_to_bid_form_locator}  ${file_path}
    capture page screenshot
    wait until element is visible                               ${bid_form_add_document_type_input_locator}
#    submit current visible popup
    Run Keyword And Ignore Error                                Select From List By Value  ${bid_form_add_document_type_input_locator}  qualificationDocuments
    click visible element                                       ${bid_form_add_document_description_btn_locator}
    capture page screenshot
    wait until element is visible                               ${bid_form_add_document_description_input_locator}
    input text to exist visible input                           ${bid_form_add_document_description_input_locator}  test2
    click visible element                                       ${bid_form_add_document_close_description_btn_locator}
    capture page screenshot

fill bid form edit
    [Arguments]                                                 ${fieldname}  ${fieldvalue}
    [Documentation]                                             Змінити поле fieldname на fieldvalue цінової пропозиції користувача username для тендера tender_uaid.

    open popup by btn locator                                   ${bid_form_open_btn_locator}  ${bid_popup_locator}
    Run Keyword If                                              '${fieldname}' == 'lotValues[0].value.amount' or '${fieldname}' == 'value.amount' and '${mode}' != 'open_esco'  input number to exist visible input  ${bid_form_value_amount_input_locator}  ${fieldvalue}
#    submit form and check result                                ${bid_form_submit_btn_locator}  ${bid_form_submit_edit_success_msg}  ${tender_created_checker_element_locator}


add document to bid
    [Arguments]                                                 ${path}  ${doc_type}  ${doc_name}
    #=documents
    [Documentation]                                             Завантажити документ типу doc_type, який знаходиться за шляхом path,
    ...                                                         до цінової пропозиції користувача username для тендера tender_uaid.

    open popup by btn locator                                   ${bid_form_open_btn_locator}  ${bid_popup_locator}
###    execute javascript                                          $('.fancybox-is-open .fancybox-content .field-bidform-documents .js-upload-documents input[type$="file"]:first').click()
    choose file                                                 ${add_file_to_bid_form_locator}  ${path}
    run keyword and ignore error                                wait until page does not contain element  ${popup_dynamic_form_loading_element_locator}
    wait until element is visible                               ${bid_form_add_document_type_input_locator}
#    submit current visible popup
    log many  ${doc_type}
#    run keyword if                                              '${doc_type}' == 'documents'  Select From List By Value  ${bid_form_add_document_type_input_locator}  qualificationDocuments
#    ...                                                         else  Select From List By Value  ${bid_form_add_document_type_input_locator}  ${doc_type}
    Run Keyword And Ignore Error  select from visible list by value  ${bid_form_add_document_type_input_locator}  commercialProposal
    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'documents' and "${mode}" not in "openeu open_competitive_dialogue"  select from visible list by value  ${bid_form_add_document_type_input_locator}  commercialProposal
    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'documents' and "${mode}" in "openeu open_competitive_dialogue"  select from visible list by value  ${bid_form_add_document_type_input_locator}  qualificationDocuments
    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'financial_documents'  select from visible list by value  ${bid_form_add_document_type_input_locator}  commercialProposal
    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'qualification_documents'  select from visible list by value  ${bid_form_add_document_type_input_locator}  qualificationDocuments
    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'eligibility_documents'  select from visible list by value  ${bid_form_add_document_type_input_locator}  eligibilityDocuments
    capture page screenshot

    Run Keyword And Ignore Error  Execute Javascript  $('.fancybox-is-open .fancybox-content .field-bidform-documents select[id*="-document_type"]:last').val('commercialProposal').change()
    capture page screenshot
    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'documents' and "${mode}" not in "openeu open_competitive_dialogue"  Execute Javascript  $('.fancybox-is-open .fancybox-content .field-bidform-documents select[id*="-document_type"]:last').val('commercialProposal').change()
    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'documents' and "${mode}" in "openeu open_competitive_dialogue"  Execute Javascript  $('.fancybox-is-open .fancybox-content .field-bidform-documents select[id*="-document_type"]:last').val('qualificationDocuments').change()
    capture page screenshot
    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'financial_documents'  Execute Javascript  $('.fancybox-is-open .fancybox-content .field-bidform-documents select[id*="-document_type"]:last').val('commercialProposal').change()
    capture page screenshot
    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'qualification_documents'  Execute Javascript  $('.fancybox-is-open .fancybox-content .field-bidform-documents select[id*="-document_type"]:last').val('qualificationDocuments').change()
    capture page screenshot
    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'eligibility_documents'  Execute Javascript  $('.fancybox-is-open .fancybox-content .field-bidform-documents select[id*="-document_type"]:last').val('eligibilityDocuments').change()
#    Run Keyword And Ignore Error  select from visible list by value  ${bid_form_add_document_type_input_locator}  commercialProposal
#    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'documents'  select from visible list by value  ${bid_form_add_document_type_input_locator}  commercialProposal
#    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'financial_documents'  select from visible list by value  ${bid_form_add_document_type_input_locator}  commercialProposal
#    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'qualification_documents'  select from visible list by value  ${bid_form_add_document_type_input_locator}  qualificationDocuments
#    Run Keyword And Ignore Error  Run Keyword If  '${doc_type}' == 'eligibility_documents'  select from visible list by value  ${bid_form_add_document_type_input_locator}  eligibilityDocuments
    capture page screenshot

    click visible element                                       ${bid_form_add_document_description_btn_locator}
    wait until element is visible                               ${bid_form_add_document_description_input_locator}
    input text to exist visible input                           ${bid_form_add_document_description_input_locator}  test2
    click visible element                                       ${bid_form_add_document_close_description_btn_locator}

document to bid edit
    [Arguments]                                                 ${path}  ${doc_type}=documents
    [Documentation]                                             Змінити документ з doc_id в описі в пропозиції користувача username для
    ...                                                         тендера tender_uaid на документ, який знаходиться по шляху path.

    open popup by btn locator                                   ${bid_form_open_btn_locator}  ${bid_popup_locator}
#    click visible element                                       ${bid_form_edit_document_all_btn_locator}
    capture page screenshot
    choose file                                                 ${bid_form_edit_document_all_btn_locator}  ${path}
    capture page screenshot
#    wait until element is visible                               ${bid_form_add_document_type_input_locator}

fill bid form edit document
    [Arguments]                                                 ${doc_data}  ${doc_id}
    [Documentation]                                             Змінити тип документа з doc_id в заголовку в пропозиції користувача
    ...                                                         username для тендера tender_uaid. Дані про новий тип документа знаходяться в doc_data.

    open popup by btn locator                                   ${bid_form_open_btn_locator}  ${bid_popup_locator}
    ##### BOF - TMP for confidentiality#####
    execute javascript                                          $('#tender-bid-form .documents-dynamic-forms-wrapper:last [href$="#edit"]:last').click()
#    click visible element                                       $('#tender-bid-form .documents-dynamic-forms-wrapper:last [href$="#edit"]:last').click()
    set element scroll into view                                ${bid_form_add_document_close_description_btn_locator}
    capture page screenshot
    wait until element is visible                               ${bid_form_add_document_description_input_locator}  60
    execute javascript                                          $('#tender-bid-form .documents-dynamic-forms-wrapper:last .popover.fade.top.in [id$="-confidentiality"]').click()

#    click visible element                                       ${bid_form_add_document_confidentiality_input_locator}
    capture page screenshot
    input text to exist visible input                           ${bid_form_add_document_confidentialityrationale_input_locator}  ${doc_data.data.confidentialityRationale}
    capture page screenshot
    click visible element                                       ${bid_form_add_document_close_description_btn_locator}
    capture page screenshot
    ##### EOF - TMP #####

get bid information
    [Arguments]                                                 ${field}
    [Documentation]                                             Отримати значення поля field пропозиції користувача
    ...                                                         username для тендера tender_uaid.

    capture page screenshot
    Run Keyword If  'status' == '${field}'                      submit form and check result   ${bid_form_refresh_btn_locator}  ${bid_form_refresh_success_msg}  ${tender_created_checker_element_locator}  ${true}
    Run Keyword If  'status' != '${field}'                      open popup by btn locator   ${bid_form_open_btn_locator}  ${bid_popup_locator}
#    click visible element                                       ${bid_form_open_btn_locator}
    capture page screenshot
    Run Keyword If  'status' != '${field}'                      wait until popup is visible
#    ${question_open_form_answer_locator} =                      replace string  ${question_open_form_answer_btn_locator_tpl}  %title%  ${question_id}
#    wait until page contains element with reloading             ${question_open_form_answer_locator}
    capture page screenshot
    Run Keyword If  'status' == '${field}'                      submit form and check result     ${bid_form_refresh_btn_locator}  ${bid_form_refresh_success_msg}  ${tender_created_checker_element_locator}  ${true}
    #${return_value} =                                           Run Keyword If  'lotValues[0].value.amount' == '${field}'         get value by locator on opened page  ${bid_lotValues_0_value_amount_value_locator}
    ${return_value} =                                           Run Keyword If  'lotValues[0].value.amount' == '${field}'         get bid value  ${bid_lotValues_0_value_amount_value_locator}
    ...  ELSE                                                   Run Keyword If  'status' == '${field}'        get value by locator on opened page  ${bid_form_bid_status_btn_locator}
    ...  ELSE                                                   Run Keyword If  'value.amount' == '${field}'   get bid value  ${bid_form_value_amount_input_locator}
##    ${return_value} =                                           Run Keyword If  'lotValues[0].value.amount' == '${field}'         get value by locator on opened page  ${bid_lotValues_0_value_amount_value_locator}
#    ...  ELSE                                                   Run Keyword If  'status' == '${field}'        get_text  ${bid_form_bid_status_btn_locator}
##    ...  ELSE                                                   Run Keyword If  'status' == '${field}'        get value by locator on opened page  ${bid_form_bid_status_btn_locator}
##    ...  ELSE                                                   Run Keyword If  'value.amount' == '${field}'   get value by locator on opened page  ${bid_form_value_amount_input_locator}
#    submit current visible popup
##    ${return_value} =                                           Run Keyword If  'lotValues[0].value.amount' == '${field}' or 'value.amount' == '${field}'   playtender_service.split_joinvalue  ${return_value}
##    ${return_value} =                                           Run Keyword If  'lotValues[0].value.amount' == '${field}' or 'value.amount' == '${field}'   Convert To Number  ${return_value}
    [Return]                                                    ${return_value}

fill bid form remove
    [Documentation]                                             Змінити статус цінової пропозиції для тендера tender_uaid
    ...                                                         користувача username на cancelled.

    click visible element                                       ${bid_form_remove_btn_locator}
    submit form and check result                                ${alert_opened_close_bid_btn_locator}  ${bid_form_submit_remove_success_msg}  ${tender_created_checker_element_locator}  ${true}

get bid value
    [Arguments]                                                 ${field}
    [Documentation]                                             Отримати значення поля field пропозиції користувача
    ...                                                         username для тендера tender_uaid.

    ${return_value} =                                           get value by locator on opened page  ${field}
    ${return_value} =                                           playtender_service.split_joinvalue  ${return_value}
    ${return_value} =                                           Convert To Number  ${return_value}
    [Return]                                                    ${return_value}

