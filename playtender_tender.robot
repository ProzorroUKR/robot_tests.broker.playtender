*** Settings ***

Resource                                                        playtender_common.robot
Resource                                                        playtender_variables.robot
Resource                                                        playtender_question.robot
Resource                                                        playtender_claim.robot
Resource                                                        playtender_bid.robot
Resource                                                        playtender_viewer.robot

*** Keywords ***

open new tender form
    [Documentation]                                             відкриття сторінки створення тендеру

    open page and wait element by locator                       ${broker_baseurl}/tender/create  ${tender_form_locator}

update tender queue
    [Documentation]                                             запускає оновлення тендерів з ЦБД і додає їх в чергу, тобто синхронізація може відбутися не відразу
    ...                                                         поточна сторіка повертається

    ${current_url} =                                            get location
    go to                                                       ${broker_baseurl}/utils/queue-tender-update
    go to                                                       ${current_url}

open tender form by uaid
    [Arguments]                                                 ${tender_uaid}
    [Documentation]                                             відкриття сторінки редагування плану

    open tender page by uaid                                    ${tender_uaid}
    click visible element and wait until page contains element  ${tender_edit_btn_locator}  ${tender_form_locator}

open tender page by uaid
    [Arguments]                                                 ${uaid}
    [Documentation]                                             відкриває сторінку з тендером

    open site page and wait content element                     ${broker_baseurl}/tender/${uaid}
    ${is_tender_found} =                                        get is element exist  ${tender_view_checker_element_locator}
    return from keyword if                                      ${is_tender_found} == ${True}
    ${is_tender_not_found} =                                    get is 404 page
    ${is_needed_to_update_and_wait_sync} =                      set variable if  ${is_test_role_owner} == ${False} and ${is_tender_not_found}  ${True}  ${False}
    run keyword if                                              ${is_needed_to_update_and_wait_sync}  update tender queue
    run keyword if                                              ${is_needed_to_update_and_wait_sync}  wait until 404 page disappears
    ${is_tender_found} =                                        get is element exist  ${tender_view_checker_element_locator}
    run keyword if                                              ${is_tender_found} == ${False}  fail  Opening tender page by uaid fails.


fill tender form
    [Arguments]                                                 ${data}
    [Documentation]                                             заповнення форми з масива даних

    fill tender general info                                    ${data}
    ${features} =                                               get from dictionary by keys  ${data}  features
    run keyword if condition is not none                        ${features}  fill tender form features  ${features}  ${tender_form_general_panel_add_feature_btn_locator}
    ${items} =                                                  get from dictionary by keys  ${data}  items
    run keyword if condition is not none                        ${items}  fill tender form items  ${items}
    ${milestones} =                                             get from dictionary by keys  ${data}  milestones
    run keyword and ignore error                                run keyword if condition is not none                        ${milestones}  fill tender form milestones  ${milestones}
    ${lots} =                                                   get from dictionary by keys  ${data}  lots
    run keyword if condition is not none                        ${lots}  fill tender form lots  ${lots}
    ${supplier_data} =                                          op_robot_tests.tests_files.service_keywords . Test Supplier Data
    run keyword if                                              '${mode}' in 'negotiation reporting'  fill tender from award reporting  ${supplier_data.data.value.amount}  ${supplier_data.data.suppliers[0]}
    Run Keyword And Ignore Error                                fill tender required documents

fill tender general info
    [Arguments]                                                 ${data}
    [Documentation]                                             обирає потрібний тип закупівлі, чекає оновлення форми, вказує мультилотовість, заповнює
    ...                                                         приховані поля + відкриває попап основних даних, заповнює його і закриває

    Execute Javascript  $(window).scrollTop(0)
    wait until page does not contain element                    ${tender_load_form_after_mode_locator}
    wait until page contains element                            ${tender_form_procurement_method_type_input_locator}
    capture page screenshot
    ${procurement_method_type} =                                get from dictionary by keys  ${data}  procurementMethodType
    capture page screenshot
    run keyword if condition is not none                        ${procurement_method_type}  select from list by value  ${tender_form_procurement_method_type_input_locator}  ${procurement_method_type}
    wait until page does not contain element                    ${tender_load_form_after_mode_locator}

    ${lots} =                                                   get from dictionary by keys  ${data}  lots
    run keyword if condition is not none                        ${lots}  Run Keyword And Ignore Error  Click Element   ${tender_multilot_locator}
    wait until page does not contain element                    ${tender_load_form_after_mode_locator}

    open popup by btn locator                                   ${plan_form_general_panel_edit_btn_locator}
    ${plan_path} =                                              Get Variable Value  ${ARTIFACT_FILE}  artifact_plan.yaml
    ${ARTIFACT} =                                               load_data_from  ${plan_path}
    run keyword and ignore error                                run keyword if condition is not none  ${ARTIFACT.tender_uaid}  input text to visible input  ${tender_form_general_tender_plan_id_locator}  ${ARTIFACT.tender_uaid}
    ${title} =                                                  get from dictionary by keys  ${data}  title
    run keyword if condition is not none                        ${title}  input text to visible input  ${tender_form_general_tender_title_locator}  ${title}
    ${title_en} =                                               get from dictionary by keys  ${data}  title_en
    run keyword if condition is not none                        ${title}  input text to exist visible input  ${tender_form_general_tender_title_en_locator}  ${title_en}
    ${description} =                                            get from dictionary by keys  ${data}  description
    run keyword if condition is not none                        ${title}  input text to visible input  ${tender_form_general_tender_description_locator}  ${description}
    ${description_en} =                                         get from dictionary by keys  ${data}  description_en
    run keyword if condition is not none                        ${title}  input text to exist visible input  ${tender_form_general_tender_description_en_locator}  ${description_en}
    ${funders} =                                                get from dictionary by keys  ${data}  funders
    run keyword if condition is not none                        ${funders}  Click Element   ${tender_form_general_tender_funder_locator}
    run keyword if condition is not none                        ${funders}  fill tender form funders  ${funders}
    ${amount} =                                                 get from dictionary by keys  ${data}  value  amount
    run keyword and ignore error                                run keyword if condition is not none                        ${amount}  run keyword and ignore error  input number to exist visible input  ${tender_form_general_value_amount_input_locator}  ${amount}
    ${currency} =                                               get from dictionary by keys  ${data}  value  currency
    run keyword if condition is not none                        ${currency}  select from visible list by value  ${tender_form_general_value_currency_input_locator}  ${currency}
    ${value_added_tax_included} =                               get from dictionary by keys  ${data}  value  valueAddedTaxIncluded
    run keyword if condition is not none                        ${value_added_tax_included}  run keyword if  ${value_added_tax_included}  Click Element  ${tender_form_general_value_added_tax_input_locator}
    ${min_step_amount} =                                        get from dictionary by keys  ${data}  minimalStep  amount
    run keyword if condition is not none                        ${min_step_amount}  input number to exist visible input  ${tender_form_general_minimalStep_amount_input_locator}  ${min_step_amount}
    ${main_procurement_category} =                              get from dictionary by keys  ${data}  mainProcurementCategory
    run keyword if condition is not none                        ${main_procurement_category}  select from visible list by value  ${tender_form_general_main_procurement_category_input_locator}  ${main_procurement_category}
    ${tender_enquiry_period_start_date} =                       get from dictionary by keys  ${data}  enquiryPeriod  startDate
#    run keyword if condition is not none                        ${tender_enquiry_period_start_date}  select from visible list by year of date  ${tender_enquiry_period_start_date_input_locator}  ${tender_enquiry_period_start_date}
    run keyword if condition is not none                        ${tender_enquiry_period_start_date}  input datetime to visible input  ${tender_enquiry_period_start_date_input_locator}  ${tender_enquiry_period_start_date}
    ${tender_enquiry_period_end_date} =                         get from dictionary by keys  ${data}  enquiryPeriod  endDate
#    run keyword if condition is not none                        ${tender_enquiry_period_start_date}  select from visible list by year of date  ${tender_enquiry_period_start_date_input_locator}  ${tender_enquiry_period_start_date}
    run keyword if condition is not none                        ${tender_enquiry_period_end_date}  input datetime to visible input  ${tender_enquiry_period_end_date_input_locator}  ${tender_enquiry_period_end_date}
    ${tender_start_date} =                                      get from dictionary by keys  ${data}  tenderPeriod  startDate
    run keyword if condition is not none                        ${tender_start_date}  run keyword and ignore error  input datetime to visible input  ${tender_tender_period_start_date_input_locator}  ${tender_start_date}
    ${tender_end_date} =                                        get from dictionary by keys  ${data}  tenderPeriod  endDate
    run keyword if condition is not none                        ${tender_end_date}  input datetime to visible input  ${tender_tender_period_end_date_input_locator}  ${tender_end_date}
    run keyword and ignore error                                click element  ${tender_tender_quick_mode_locator}
    ${classification} =                                         get from dictionary by keys  ${data}  classification
    run keyword if condition is not none                        ${classification}  select classification by code attributes  ${plan_form_classification_edit_btn_locator}  ${classification}
    ${additional_classifications} =                             get from dictionary by keys  ${data}  additionalClassifications
    run keyword if condition is not none                        ${additional_classifications}  select classification by array of code attributes  ${plan_form_additional_classification_edit_btn_locator}  ${additional_classifications}  ${None}  ${kekv_schemes}
    run keyword if condition is not none                        ${additional_classifications}  select classification by array of code attributes  ${plan_form_kekv_classification_edit_btn_locator}  ${additional_classifications}  ${kekv_schemes}
    ${funding_kind} =                                           get from dictionary by keys  ${data}  fundingKind
    run keyword if condition is not none                        ${funding_kind}  select from visible list by value  ${tender_form_general_funding_kind_input_locator}  ${funding_kind}
#esco
    ${nbu_discount_rate} =                                      get from dictionary by keys  ${data}  NBUdiscountRate
    ${nbu_discount_rate} =                                      Run keyword If  '${nbu_discount_rate}' != '${None}'      set_value_minimalStepPercentage  ${nbu_discount_rate}
    ${nbu_discount_rate} =                                      Run keyword If  '${nbu_discount_rate}' != '${None}'      convert_esco__float_to_string  ${nbu_discount_rate}
    run keyword and ignore error                                run keyword if condition is not none                        ${nbu_discount_rate}  input number to exist visible input  ${tender_form_general_nbu_discount_rate_input_locator}  ${nbu_discount_rate}
#closeframework
    ${max_awards_count} =                                       get from dictionary by keys  ${data}  maxAwardsCount
    run keyword if condition is not none                        ${max_awards_count}  input text to exist visible input  ${tender_form_general_max_awards_count_input_locator}  ${max_awards_count}
    ${agreement_duration_years} =                               get from dictionary by keys  ${data}  agreementDuration
    ${agreement_duration_years1}=                               Run keyword If  '${agreement_duration_years}' != '${None}'  split_agreementDuration  ${agreement_duration_years}  year
    run keyword if condition is not none                        ${agreement_duration_years}  select from visible list by value  ${tender_form_general_agreement_duration_years_input_locator}  ${agreement_duration_years1}
    ${agreement_duration_months} =                              get from dictionary by keys  ${data}  agreementDuration
    ${agreement_duration_months1}=                              Run keyword If  '${agreement_duration_months}' != '${None}'  split_agreementDuration  ${agreement_duration_months}  month
    run keyword if condition is not none                        ${agreement_duration_months}  select from visible list by value  ${tender_form_general_agreement_duration_months_input_locator}  ${agreement_duration_months1}
    ${agreement_duration_days} =                                get from dictionary by keys  ${data}  agreementDuration
    ${agreement_duration_days1}=                                Run keyword If  '${agreement_duration_days}' != '${None}'  split_agreementDuration  ${agreement_duration_years}  day
    run keyword if condition is not none                        ${agreement_duration_days}  select from visible list by value  ${tender_form_general_agreement_duration_days_input_locator}  ${agreement_duration_days1}
#negotiation
    ${cause} =                                                  get from dictionary by keys  ${data}  cause
    run keyword if condition is not none                        ${cause}  select from visible list by value  ${tender_form_general_cause_input_locator}  ${cause}
    ${cause_description} =                                      get from dictionary by keys  ${data}  causeDescription
    run keyword if condition is not none                        ${cause_description}  input text to visible input  ${tender_form_general_cause_description_input_locator}  ${cause_description}
#complaints
    Run Keyword If                                              '${SUITE_NAME}' == 'Tests Files.Complaints'  click visible element  ${tender_form_auction_skip_mode_input_locator}
    submit current visible popup

fill tender form items
    [Arguments]                                                 ${item_attributes_array}
    [Documentation]                                             заповнення номенклатури тендеру

#    ${report} =                                                 set variable if  "${mode}" in "reporting"  1  0
    :FOR  ${item_attributes}  IN  @{item_attributes_array}
    \  run keyword and ignore error                             click visible element  ${tender_form_item_add_edit_btn_locator}
#    \  run keyword and ignore error                             run keyword if  "${mode}" not in "reporting" or ${report} == 2  click visible element  ${tender_form_item_add_edit_btn_locator}
#    \  run keyword and ignore error                             run keyword if  "${mode}" in "reporting" and ${report} == 1  click visible element  ${tender_form_lots_add_item_reporting_btn_locator}
    \  wait until popup is visible
    \  fill tender item form in opened popup                    ${item_attributes}
    \  submit current visible popup
    \  ${features} =                                            get from dictionary by keys  ${item_attributes}  features
    \  run keyword if condition is not none                     ${features}  fill tender form features  ${features}  ${tender_form_item_panel_add_feature_btn_locator}
#    \  ${report} =                                              set variable if  "${mode}" in "reporting"  2

fill tender item form in opened popup
    [Arguments]                                                 ${data}
    [Documentation]                                             заповнює відкриту форму згідно вказаних даних

    fill item form in opened popup                              ${data}

    ${region} =                                                 get from dictionary by keys  ${data}  deliveryAddress  region
    run keyword if condition is not none                        ${region}  select from visible list by label  ${item_form_popup_delivery_region_id_input_locator}  ${region}
    ${postal_code} =                                            get from dictionary by keys  ${data}   deliveryAddress  postalCode
    run keyword if condition is not none                        ${postal_code}  input text to visible input  ${item_form_popup_delivery_postal_code_input_locator}  ${postal_code}
    ${locality} =                                               get from dictionary by keys  ${data}  deliveryAddress  locality
    run keyword if condition is not none                        ${locality}  input text to visible input  ${item_form_popup_delivery_locality_input_locator}  ${locality}
    ${street_address} =                                         get from dictionary by keys  ${data}  deliveryAddress  streetAddress
    run keyword if condition is not none                        ${street_address}  input text to visible input  ${item_form_popup_delivery_street_address_input_locator}  ${street_address}
    ${delivery_start_date} =                                    get from dictionary by keys  ${data}  deliveryDate  startDate
    run keyword if condition is not none                        ${delivery_start_date}  run keyword and ignore error  input datetime to exist visible input  ${item_form_popup_delivery_start_date_input_locator}  ${delivery_start_date}
    ${delivery_end_date} =                                      get from dictionary by keys  ${data}  deliveryDate  endDate
    run keyword if condition is not none                        ${delivery_end_date}  run keyword and ignore error  input datetime to exist visible input  ${item_form_popup_delivery_end_date_input_locator}  ${delivery_end_date}

fill tender form milestones
    [Arguments]                                                 ${milestone_attributes_array}
    [Documentation]                                             заповнення умов оплати тендеру

    click visible element                                       ${tender_form_milestones_panel_edit_btn_locator}
    wait until popup is visible
    :FOR  ${milestone_attributes}  IN  @{milestone_attributes_array}
    \  click visible element                                    ${milestone_form_popup_add_btn_locator}
    \  wait until page does not contain element                 ${popup_dynamic_form_loading_element_locator}
    \  fill milestone form in opened popup                      ${milestone_attributes}
    submit current visible popup

fill milestone form in opened popup
    [Arguments]                                                 ${data}
    [Documentation]                                             заповнює відкриту форму в активній вкладці згідно вказаних даних

    ${title} =                                                  get from dictionary by keys  ${data}  title
    run keyword if condition is not none                        ${title}  select from visible list by value  ${milestone_form_popup_title_input_locator}  ${title}
    ${description} =                                            get from dictionary by keys  ${data}  description
    run keyword if condition is not none                        ${description}  input text to exist visible input  ${milestone_form_popup_description_input_locator}  ${description}
    ${percentage} =                                             get from dictionary by keys  ${data}  percentage
    run keyword if condition is not none                        ${percentage}  input text to exist visible input  ${milestone_form_popup_percentage_input_locator}  ${percentage}
    ${code} =                                                   get from dictionary by keys  ${data}  code
    run keyword if condition is not none                        ${code}  select from visible list by value  ${milestone_form_popup_code_input_locator}  ${code}
    ${duration_days} =                                          get from dictionary by keys  ${data}  duration  days
    run keyword if condition is not none                        ${duration_days}  input text to exist visible input  ${milestone_form_popup_duration_days_input_locator}  ${duration_days}
    ${duration_type} =                                          get from dictionary by keys  ${data}  duration  type
    run keyword if condition is not none                        ${duration_type}  select from visible list by value  ${milestone_form_popup_duration_type_input_locator}  ${duration_type}

fill tender form features
    [Arguments]                                                 ${feature_attributes_array}  ${add_btn_locator}
    [Documentation]                                             заповнення нецінові крітерії тендеру

    click visible element                                       ${add_btn_locator}
    wait until popup is visible
    :FOR  ${feature_attributes}  IN  @{feature_attributes_array}
#    \  click visible element                                    ${tender_form_features_panel_edit_btn_locator}
    \  execute javascript                                    ${tender_form_features_panel_edit_btn_locator}
    \  wait until page does not contain element                 ${popup_dynamic_form_loading_element_locator}
    \  fill feature form in opened popup                        ${feature_attributes}
    submit current visible popup

fill tender form features2
    [Arguments]                                                 ${feature_attributes_array}  ${add_btn_locator}
    [Documentation]                                             заповнення нецінові крітерії тендеру

    click visible element                                       ${add_btn_locator}
    wait until popup is visible
    click visible element                                       ${tender_form_features_panel_edit_btn_locator}
    wait until page does not contain element                    ${popup_dynamic_form_loading_element_locator}
    fill feature form in opened popup                           ${feature_attributes_array}
    submit current visible popup

fill feature form in opened popup
    [Arguments]                                                 ${data}
    [Documentation]                                             заповнює відкриту форму в активній вкладці згідно вказаних даних

    ${title} =                                                  get from dictionary by keys  ${data}  title
    run keyword if condition is not none                        ${title}  input text to exist visible input  ${feature_form_popup_title_input_locator}  ${title}
    ${description} =                                            get from dictionary by keys  ${data}  description
    run keyword if condition is not none                        ${description}  input text to exist visible input  ${feature_form_popup_description_input_locator}  ${description}
    ${title_en} =                                               get from dictionary by keys  ${data}  title_en
    run keyword if condition is not none                        ${title_en}  input text to exist visible input  ${feature_form_popup_title_en_input_locator}  ${title_en}
    ${description_en} =                                         get from dictionary by keys  ${data}  description
    run keyword if condition is not none                        ${description_en}  input text to exist visible input  ${feature_form_popup_description_en_input_locator}  ${description_en}
    ${options} =                                                Get From Dictionary  ${data}  enum
    ${count} =                                                  Get Length  ${options}
    ${ex}=  Evaluate  ${count} - 1
    : FOR    ${INDEX}    IN RANGE    0    ${count}
    \  run keyword if condition is not none                     ${options[${INDEX}].title}  input text to exist visible input  ${feature_form_popup_enum_title_input_locator}  ${options[${INDEX}].title}
    \  run keyword and ignore error                             input text to exist visible input  ${feature_form_popup_enum_title_en_input_locator}  test2
#    \  run keyword if condition is not none                     ${options[${INDEX}].title_en}  input text to exist visible input  ${feature_form_popup_enum_title_en_input_locator}  ${options[${INDEX}].title_en}
    \  ${value} =                                               convert_float_to_string  ${options[${INDEX}].value}
    \  ${value} =                                               Convert To Number  ${value}
    \  ${value} =                                               multiply_hundred  ${value}
    \  ${value} =                                               convert_float_to_string  ${value}
    \  run keyword if condition is not none                     ${options[${INDEX}].value}  input text to exist visible input  ${feature_form_popup_enum_value_input_locator}  ${value}
    \  Continue For Loop If                                     '${INDEX}' == '${ex}'
    \  Run Keyword If  ${count} != 1                            click visible element    ${feature_form_popup_add-enums_btn_locator}
    \  wait until page does not contain element                 ${popup_dynamic_form_loading_element_locator}

fill tender form lots
    [Arguments]                                                 ${lot_attributes_array}
    [Documentation]                                             заповнення номенклатури тендеру

    ##### BOF - TMP  for negotiation milestone 1 lot#####
    ${prepared_tender_data} =                                   Get From Dictionary    ${td_railway_crutch}  data
    ${milestones1} =                                            Run Keyword If  "${mode}" in "negotiation"  Get From Dictionary    ${prepared_tender_data}   milestones
    ##### EOF - TMP #####
    :FOR  ${lot_attributes}  IN  @{lot_attributes_array}
    \  click visible element                                    ${tender_form_lots_panel_edit_btn_locator}
    \  wait until popup is visible
    \  fill lot form in opened popup                            ${lot_attributes}
    \  submit current visible popup
    \  ${features} =                                            get from dictionary by keys  ${lot_attributes}  features
    \  run keyword if condition is not none                     ${features}  fill tender form features  ${features}  ${tender_form_lot_panel_add_feature_btn_locator}
    \  ${milestones} =                                          get from dictionary by keys  ${lot_attributes}  milestones
    \  run keyword if condition is not none                     ${milestones}  fill tender form milestones  ${milestones}
    \  run keyword if condition is none                         ${milestones}  run keyword if  "${mode}" in "negotiation"  fill tender form milestones  ${milestones1}
    \  ${items} =                                               get from dictionary by keys  ${lot_attributes}  items
    \  run keyword if condition is not none                     ${items}  fill tender form items  ${items}

fill lot form in opened popup
    [Arguments]                                                 ${data}
    [Documentation]                                             заповнює відкриту форму згідно вказаних даних

    log many  ${data}
    ${title} =                                                  get from dictionary by keys  ${data}  title
    run keyword if condition is not none                        ${title}  input text to visible input  ${lot_form_popup_title_input_locator}  ${title}
    ${title_en} =                                               get from dictionary by keys  ${data}  title_en
    run keyword if condition is not none                        ${title_en}  input text to exist visible input  ${lot_form_popup_title_en_input_locator}  ${title_en}
    ${description} =                                            get from dictionary by keys  ${data}  description
    run keyword if condition is not none                        ${description}  input text to visible input  ${lot_form_popup_description_input_locator}  ${description}
    ${description_en} =                                         get from dictionary by keys  ${data}  description_en
    run keyword if condition is not none                        ${description_en}  input text to exist visible input  ${lot_form_popup_description_en_input_locator}  ${description_en}
    capture page screenshot
    ${description_ru} =                                         get from dictionary by keys  ${data}  description_ru
    run keyword if condition is not none                        ${description_ru}  input text to exist visible input  ${item_form_popup_description_ru_input_locator}  ${description_ru}
    ${amount} =                                                 get from dictionary by keys  ${data}  value  amount
    run keyword if condition is not none                        ${amount}  input number to exist visible input  ${lot_form_popup_value_amount_input_locator}  ${amount}
    ${min_step_amount} =                                        get from dictionary by keys  ${data}  minimalStep  amount
    run keyword if condition is not none                        ${min_step_amount}  input number to exist visible input  ${lot_form_popup_minimalstep_amount_input_locator}  ${min_step_amount}

    ${yearly_payments_percentage_range} =                       get from dictionary by keys  ${data}  yearlyPaymentsPercentageRange
    ${yearly_payments_percentage_range} =                       Run keyword If  '${yearly_payments_percentage_range}' != '${None}'      set_value_minimalStepPercentage  ${yearly_payments_percentage_range}
    ${yearly_payments_percentage_range} =                       Run keyword If  '${yearly_payments_percentage_range}' != '${None}'      convert_esco__float_to_string  ${yearly_payments_percentage_range}
    run keyword if condition is not none                        ${yearly_payments_percentage_range}  input number to exist visible input  ${tender_form_general_yearly_payments_percentage_range_input_locator}  ${yearly_payments_percentage_range}
    ${minimal_step_percentage} =                                get from dictionary by keys  ${data}  minimalStepPercentage
    ${minimal_step_percentage} =                                Run keyword If  '${minimal_step_percentage}' != '${None}'      set_value_minimalStepPercentage  ${minimal_step_percentage}
    ${minimal_step_percentage} =                                Run keyword If  '${minimal_step_percentage}' != '${None}'      convert_esco__float_to_string  ${minimal_step_percentage}
    run keyword if condition is not none                        ${minimal_step_percentage}  input number to exist visible input  ${tender_form_general_minimal_step_percentage_input_locator}  ${minimal_step_percentage}
#    ${currency} =                                               get from dictionary by keys  ${data}  value  currency
#    run keyword if condition is not none                        ${currency}  select from visible list by value  ${tender_form_lots_value_currency_input_locator}  ${currency}
#    ${valueAddedTaxIncluded} =                                  get from dictionary by keys  ${data}  value  valueAddedTaxIncluded
#    run keyword if condition is not none                        ${valueAddedTaxIncluded}  run keyword if  ${valueAddedTaxIncluded}  Click Element  ${tender_form_lots_value_added_tax_input_locator}

fill tender form funders
    [Arguments]                                                 ${funder_attributes_array}
    [Documentation]                                             заповнення донорів тендеру

    :FOR  ${funder_attributes}  IN  @{funder_attributes_array}
    \  ${name} =                                                  get from dictionary by keys  ${funder_attributes}  name
    \  run keyword if condition is not none                       ${name}  select from visible list by label   ${tender_form_general_tender_funder_name_locator}  ${name}

fill tender required documents
    [Documentation]                                             додає документ до усієї закупівлі для успішної валідації форми

    ${file_path}  ${file_name}  ${file_content} =               create_fake_doc
    click visible element                                       ${tender_form_general_panel_add_document_btn_locator}
    choose file                                                 ${add_file_to_form_locator}  ${file_path}
    wait until page does not contain element                    ${popup_dynamic_form_loading_element_locator}
    submit current visible popup

fill tender from award reporting
    [Arguments]                                                 ${budget}  ${award_attributes_array}
    [Documentation]                                             заповнення переможця reporting тендеру

    run keyword and ignore error                                click visible element  ${tender_form_general_panel_update_award_negotiation_btn_locator}
    run keyword and ignore error                                Run Keyword If  "${TEST_NAME}" == "Можливість створити переговорну процедуру"  click visible element  ${tender_form_general_panel_add_award_negotiation_btn_locator}
    run keyword and ignore error                                wait until popup is visible
    run keyword and ignore error                                click visible element  ${tender_form_general_panel_update_award_reporting_btn_locator}
    wait until popup is visible
    fill award reporting form in opened popup                   ${budget}  ${award_attributes_array}
    submit current visible popup

fill award reporting form in opened popup
    [Arguments]                                                 ${budget}  ${data}
    [Documentation]                                             заповнює відкриту форму в активній вкладці згідно вказаних даних

    ${org_name} =                                               get from dictionary by keys  ${data}  identifier  legalName
    run keyword if condition is not none                        ${org_name}  input text to exist visible input  ${tender_form_award_organization_name_locator}  ${org_name}
    ${organization_identifier_code} =                           get from dictionary by keys  ${data}  identifier  id
    run keyword if condition is not none                        ${organization_identifier_code}  input text to exist visible input  ${tender_form_award_organization_identifier_code_locator}  ${organization_identifier_code}
    ${award_organization_scale} =                               get from dictionary by keys  ${data}  scale
    run keyword if condition is not none                        ${award_organization_scale}  select from visible list by value  ${tender_form_award_organization_scale_locator}  ${award_organization_scale}
    ${region} =                                                 get from dictionary by keys  ${data}  address  region
    run keyword if condition is not none                        ${region}  select from visible list by label  ${tender_form_award_organization_region_id_locator}  ${region}
    ${postal_code} =                                            get from dictionary by keys  ${data}  address  postalCode
    run keyword if condition is not none                        ${postal_code}  input text to exist visible input  ${tender_form_award_organization_postal_code_locator}  ${postal_code}
    ${locality} =                                               get from dictionary by keys  ${data}  address  locality
    run keyword if condition is not none                        ${locality}  input text to exist visible input  ${tender_form_award_organization_locality_locator}  ${locality}
    ${street_address} =                                         get from dictionary by keys  ${data}  address  streetAddress
    run keyword if condition is not none                        ${street_address}  input text to exist visible input  ${tender_form_award_organization_street_address_locator}  ${street_address}
    ${contact_point_name} =                                     get from dictionary by keys  ${data}  contactPoint  name
    run keyword if condition is not none                        ${contact_point_name}  input text to exist visible input  ${tender_form_award_organization_contact_point_name_locator}  ${contact_point_name}
    ${contact_point_email} =                                    get from dictionary by keys  ${data}  contactPoint  email
    run keyword if condition is not none                        ${contact_point_email}  input text to exist visible input  ${tender_form_award_organization_contact_point_email_locator}  ${contact_point_email}
    ${contact_point_phone} =                                    get from dictionary by keys  ${data}  contactPoint  telephone
    run keyword if condition is not none                        ${contact_point_phone}  input text to exist visible input  ${tender_form_award_organization_contact_point_phone_locator}  ${contact_point_phone}
#    ${duration_days} =                                          get from dictionary by keys  ${data}  contactPoint  days
#    run keyword if condition is not none                        ${duration_days}  input text to exist visible input  ${milestone_form_popup_duration_days_input_locator}  ${duration_days}
    input number to exist visible input                         ${tender_form_award_budget_locator}  ${budget}

open tender search form
    [Documentation]                                             відкриває сторінку з пошуком тендерів

    open page and wait element by locator                       ${broker_baseurl}/tenders  ${tender_search_form_locator}

save tender form and wait synchronization
    [Documentation]                                             натискає кнопку "Зберегти" і чекає синхронізації тендеру

    submit form and check result                                ${tender_form_submit_btn_locator}  ${tender_form_submit_success_msg}  ${tender_created_checker_element_locator}
    wait until page does not contain element with reloading     ${tender_sync_element_locator}

add document in tender
    [Arguments]                                                 ${filepath}
    [Documentation]                                             Завантажити документ, який знаходиться по шляху filepath.

    click visible element                                       ${tender_form_general_panel_edit_add_document_btn_locator}
    choose file                                                 ${add_file_to_form_locator}  ${filepath}
    wait until page does not contain element                    ${popup_dynamic_form_loading_element_locator}
    submit current visible popup

add document in lot
    [Arguments]                                                 ${filepath}  ${lot_id}
    [Documentation]                                             Завантажити в лот (з ідентіфікатором ${lot_id}) документ, який знаходиться по шляху filepath.

    ${open_form_add_doc_lot_btn_locator} =                      replace string  ${tender_form_lot_panel_add_document_btn_locator_tpl}  %lot_id%  ${lot_id}
    click visible element and wait until page contains element  ${open_form_add_doc_lot_btn_locator}   jquery=.modal.modal-form.js-form-popup.fancybox-content
    choose file                                                 ${add_file_to_form_locator}  ${filepath}
    wait until page does not contain element                    ${popup_dynamic_form_loading_element_locator}
    submit current visible popup

confirm-stage2
    [Documentation]                                             Перевести тендер tender_uaid в статус active.stage2.waiting.

    Wait Until Keyword Succeeds                                 300 s    20 s    Wait For stage2button
    click visible element                                       ${tender_stage2_open_btn_locator}
    Wait Until Page Contains                                    ${tender_stage2_submit_success_msg}   60
#    click visible element                                       ${tender_stage2_submit_success_btn_locator}
#    submit form and check result                                ${tender_stage2_submit_success_btn_locator}  ${tender_stage2_submit_alert_success_msg}  ${tender_created_checker_element_locator}
    execute javascript  ${tender_stage2_submit_js_success_btn_locator}
    Wait Until Page Contains                                    ${tender_stage2_submit_alert_success_msg}  60
    wait until alert is visible                                 ${tender_stage2_submit_alert_success_msg}
    run keyword and ignore error                                close current visible alert


activate stage 2
    [Documentation]                                             Перевести тендер tender_uaid в статус active.tendering.

    open popup by btn locator                                   ${tender_form_general_panel_edit_btn_locator}
    ${tender_end_date} =                                        Get Current Date  increment=00:30:00
    input datetime to visible input                             ${tender_tender_period_end_date_input_locator}  ${tender_end_date}
    capture page screenshot
    click visible element                                       ${tender_form_general_panel_draft_mode_input_locator}
    capture page screenshot
    submit current visible popup
    capture page screenshot
    ${file_path}  ${file_name}  ${file_content} =               create_fake_doc
    click visible element                                       ${tender_form_general_panel_document_stage2_input_locator}
    choose file                                                 ${add_file_to_form_locator}  ${file_path}
    wait until element is visible                               ${stage2_form_add_document_type_input_locator}
    click visible element                                       ${stage2_form_add_document_description_btn_locator}
    capture page screenshot
    wait until element is visible                               ${stage2_form_add_document_description_input_locator}
    input text to exist visible input                           ${stage2_form_add_document_description_input_locator}  test2
    click visible element                                       ${stage2_form_add_document_close_description_btn_locator}
    capture page screenshot
    submit current visible popup

fix awards data in global Users variable
    [Arguments]                                                 ${username}
    [Documentation]                                             Фікс для помилки "Resolving variable '${award.value.amount}' failed: AttributeError: value"

    :FOR    ${user}    IN    @{USERS}
    \  continue for loop if                                     '${user}' == '${username}'
    \  ${user_data} = 						                    set variable  ${USERS.users['${user}']}
    \  ${is_user_has_tender_data} =                             run keyword and return status  dictionary should contain key  ${user_data}  tender_data
    \  continue for loop if                                     ${is_user_has_tender_data} == ${False}
    \  ${status}  ${award_data} =                               run keyword and ignore error  get_from_object  ${USERS.users['${user}'].tender_data.data}  awards
    \  continue for loop if                                     '${status}' != 'PASS'
    \  set to object                                            ${USERS.users['${username}'].tender_data.data}  awards  ${award_data}
    \  exit for loop