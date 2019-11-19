*** Settings ***

Resource                                                        playtender_common.robot
Resource                                                        playtender_plan_variables.robot

*** Keywords ***

update plan queue
    [Documentation]                                             запускає оновлення планів з ЦБД і додає їх в чергу, тобто синхронізація може відбутися не відразу
    ...                                                         поточна сторіка повертається

    ${current_url} =                                            get location
    go to                                                       ${broker_baseurl}/utils/queue-plan-update
    go to                                                       ${current_url}

open new plan form
    [Documentation]                                             відкриття сторінки створення плану

    open page and wait element by locator                       ${broker_baseurl}/plan/create  ${plan_form_locator}

open plan form by uaid
    [Arguments]                                                 ${plan_uaid}
    [Documentation]                                             відкриття сторінки редагування плану

    open plan page by uaid                                      ${plan_uaid}
    click visible element and wait until page contains element  ${plan_edit_btn_locator}  ${plan_form_locator}

open plan page by uaid
    [Arguments]                                                 ${uaid}  ${refresh}=${True}
    [Documentation]                                             відкриває сторінку з планом

    ${current_location} =                                       get location
    ${needed_location} =                                        set variable  ${broker_baseurl}/plan/${uaid}
    run keyword if                                              '${current_location}' != '${needed_location}' or ${refresh} == ${True}  open site page and wait content element  ${needed_location}
    ${is_plan_found} =                                          get is element exist  ${plan_view_checker_element_locator}
    return from keyword if                                      ${is_plan_found} == ${True}
    ${is_plan_not_found} =                                      get is 404 page
    ${is_needed_to_update_and_wait_sync} =                      set variable if  ${is_test_role_owner} == ${False} and ${is_plan_not_found}  ${True}  ${False}
    run keyword if                                              ${is_needed_to_update_and_wait_sync}  update plan queue
    run keyword if                                              ${is_needed_to_update_and_wait_sync}  wait until 404 page disappears
    ${is_plan_found} =                                          get is element exist  ${plan_view_checker_element_locator}
    run keyword if                                              ${is_plan_found} == ${False}  fail  Opening plan page by uaid fails.

open plan search form
    [Documentation]                                             відкриває сторінку з пошуком планів

    open page and wait element by locator                       ${broker_baseurl}/plans  ${plan_search_form_locator}

fill plan form
    [Arguments]                                                 ${data}
    [Documentation]                                             заповнення відкритої форми з масива даних

    fill plan general info                                      ${data}
    ${items} =                                                  get from dictionary by keys  ${data}  items
    run keyword if condition is not none                        ${items}  fill plan form items  ${items}
    ${buyers} =                                                 get from dictionary by keys  ${data}  buyers
    run keyword if condition is not none                        ${buyers}  fill plan form buyers  ${buyers}
#Пока не передает Дятлов
#    ${budget_breakdowns} =                                      get from dictionary by keys  ${data}  BudgetBreakdowns
#    run keyword if condition is not none                        ${budget_breakdowns}  fill plan form budgetbreakdowns  ${budget_breakdowns}
    fill plan form budgetbreakdowns

fill plan general info
    [Arguments]                                                 ${data}
    [Documentation]                                             заповнює приховані поля + відкриває попап основних даних, заповнює його і закриває

    # hidden inputs
    ${budget_id} =                                              get from dictionary by keys  ${data}  budget  id
    run keyword if condition is not none                        ${budget_id}  input text to hidden input  ${plan_form_budget_id_input_locator}  ${budget_id}
    ${project_id} =                                             get from dictionary by keys  ${data}  budget  project  id
    run keyword if condition is not none                        ${project_id}  input text to hidden input  ${plan_form_project_id_input_locator}  ${project_id}
    ${project_name} =                                           get from dictionary by keys  ${data}  budget  project  name
    run keyword if condition is not none                        ${project_name}  input text to hidden input  ${plan_form_project_name_input_locator}  ${project_name}

    # general info
    open popup by btn locator                                   ${plan_form_general_panel_edit_btn_locator}
    ${procurement_method_type} =                                get from dictionary by keys  ${data}  tender  procurementMethodType
    run keyword if condition is not none                        ${procurement_method_type}  select from visible list by value  ${plan_form_procurement_method_type_input_locator}  ${procurement_method_type}
    ${budget_description} =                                     get from dictionary by keys  ${data}  budget  description
    run keyword if condition is not none                        ${budget_description}  input text to visible input  ${plan_form_title_input_locator}  ${budget_description}
    ${tender_start_date} =                                      get from dictionary by keys  ${data}  tender  tenderPeriod  startDate
    run keyword if condition is not none                        ${tender_start_date}  select from visible list by year of date  ${plan_form_year_input_locator}  ${tender_start_date}
    run keyword if condition is not none                        ${tender_start_date}  input month.year of date to visible input  ${plan_form_tender_start_date_input_locator}  ${tender_start_date}
    ${amount} =                                                 get from dictionary by keys  ${data}  budget  amount
    run keyword and ignore error                                run keyword if condition is not none                        ${amount}  input number to visible input  ${plan_form_value_amount_input_locator}  ${amount}
    ${currency} =                                               get from dictionary by keys  ${data}  budget  currency
    run keyword if condition is not none                        ${currency}  select from visible list by value  ${plan_form_value_currency_input_locator}  ${currency}
    ${classification} =                                         get from dictionary by keys  ${data}  classification
    run keyword if condition is not none                        ${classification}  select classification by code attributes  ${plan_form_classification_edit_btn_locator}  ${classification}
    ${additional_classifications} =                             get from dictionary by keys  ${data}  additionalClassifications
    run keyword if condition is not none                        ${additional_classifications}  select classification by array of code attributes  ${plan_form_additional_classification_edit_btn_locator}  ${additional_classifications}  ${None}  ${kekv_schemes}
    run keyword if condition is not none                        ${additional_classifications}  select classification by array of code attributes  ${plan_form_kekv_classification_edit_btn_locator}  ${additional_classifications}  ${kekv_schemes}
    submit current visible popup

fill plan form items
    [Arguments]                                                 ${item_attributes_array}
    [Documentation]                                             заповнення номенклатури плану

    :FOR  ${item_attributes}  IN  @{item_attributes_array}
    \  ${item_update_index} =                                   get from dictionary by keys  ${item_attributes}  list_index
    \  ${item_update_index_string} =                            convert to string  ${item_update_index}
    \  ${open_form_btn_locator} =                               replace string  ${plan_form_update_item_btn_locator_tpl}  %index%  ${item_update_index_string}
    \  run keyword if condition is not none                     ${item_update_index}  click visible element  ${open_form_btn_locator}
    \  run keyword if condition is none                         ${item_update_index}  click visible element  ${plan_form_add_item_btn_locator}
    \  wait until popup is visible
    \  fill plan item form in opened popup                      ${item_attributes}
    \  run keyword and ignore error  submit current visible popup

fill plan item form in opened popup
    [Arguments]                                                 ${data}

    fill item form in opened popup                              ${data}

    ${delivery_end_date} =                                      get from dictionary by keys  ${data}  deliveryDate  endDate
    run keyword if condition is not none                        ${delivery_end_date}  run keyword and ignore error  input date to input  ${item_form_popup_delivery_end_date_input_locator}  ${delivery_end_date}

fill plan form buyers
    [Arguments]                                                 ${buyer_attributes_array}
    [Documentation]                                             заповнення замовника плану

    :FOR  ${buyer_attributes}  IN  @{buyer_attributes_array}
    \  click visible element                                    ${plan_form_update_buyer_btn_locator}
    \  wait until popup is visible
    \  fill buyer form in opened popup                          ${buyer_attributes}
    \  submit current visible popup

fill buyer form in opened popup
    [Arguments]                                                 ${data}
    [Documentation]                                             заповнює відкриту форму згідно вказаних даних про замовника

    ${legal_name} =                                             get from dictionary by keys  ${data}  identifier  legalName
    run keyword if condition is not none                        ${legal_name}  input text to visible input  ${buyer_form_popup_legal_name_input_locator}  ${legal_name}
    ${identifier_id} =                                          get from dictionary by keys  ${data}  identifier  id
    run keyword if condition is not none                        ${identifier_id}  input text to visible input  ${buyer_form_popup_identifier_id_input_locator}  ${identifier_id}

fill plan form budgetbreakdowns
#    [Arguments]                                                 ${budgetbreakdowns_attributes_array}
    [Documentation]                                             заповнення Джерел фінансування плану

    click visible element                                       ${plan_form_update_budgetbreakdowns_btn_locator}
    wait until popup is visible
#    :FOR  ${budgetbreakdowns_attributes}  IN  @{budgetbreakdowns_attributes_array}
#    \  click visible element                                    ${plan_form_add_budgetbreakdowns_btn_locator}
#    \  wait until page does not contain element                 ${popup_dynamic_form_loading_element_locator}
#    \  fill budgetbreakdowns form in opened popup               ${budgetbreakdowns_attributes}
#    \  submit current visible popup
    click visible element                                    ${plan_form_add_budgetbreakdowns_btn_locator}
    wait until page does not contain element                 ${popup_dynamic_form_loading_element_locator}
    fill budgetbreakdowns form in opened popup
#    fill budgetbreakdowns form in opened popup               ${budgetbreakdowns_attributes}
    submit current visible popup

fill budgetbreakdowns form in opened popup
#    [Arguments]                                                 ${data}
    [Documentation]                                             заповнює відкриту форму згідно вказаних даних про Джерела фінансування

#    ${title} =                                                  get from dictionary by keys  ${data}  title
#    run keyword if condition is not none                        ${title}  select from visible list by label  ${plan_budgetbreakdowns_form_popup_title_input_locator}  ${title}
#    ${value_amount} =                                           get from dictionary by keys  ${data}  value  amount
#    run keyword if condition is not none                        ${value_amount}  input number to visible input  ${plan_budgetbreakdowns_value_amount_input_locator}  ${amount}
    input number to visible input                               ${plan_budgetbreakdowns_value_amount_input_locator}  56333.77
#    ${description} =                                            get from dictionary by keys  ${data}  description
#    run keyword if condition is not none                        ${description}  input text to visible input  ${plan_budgetbreakdowns_description_input_locator}  ${description}
    input text to visible input                                 ${plan_budgetbreakdowns_description_input_locator}  description

save plan form and wait synchronization
    [Documentation]                                             натискає кнопку "Зберегти" і чекає синхронізації плану

    submit form and check result                                ${plan_form_submit_btn_locator}  ${plan_form_submit_success_msg}  ${plan_created_checker_element_locator}
    wait until page does not contain element with reloading     ${plan_sync_element_locator}

