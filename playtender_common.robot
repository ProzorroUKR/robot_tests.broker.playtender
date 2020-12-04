*** Settings ***

Library                                                         Selenium2Library
Library                                                         String
Library                                                         Collections
Library                                                         playtender_service.py
Resource                                                        playtender_variables.robot

*** Variables ***

${broker} =                                                     playtender
${broker_username} =
${broker_baseurl} =
${broker_browser} =
${broker_language_code} =                                       uk
${test_role} =
${is_test_role_owner} =

@{browser_default_size} =                                       ${1200}  ${1000}
@{browser_default_position} =                                   ${0}  ${0}

${popup_transaction_time} =                                     600ms

*** Keywords ***

init environment
    [Arguments]                                                 ${username}
    [Documentation]                                             ініціює необхідні глобальні змінні

    set global variable                                         ${broker_username}  ${username}
    set global variable                                         ${broker_baseurl}  ${BROKERS['${broker}'].basepage}
    set global variable                                         ${broker_browser}  ${USERS.users['${broker_username}'].browser}
    set global variable                                         ${test_role}  ${ROLE}
    ${is_test_role_owner} =                                     set variable if  '${test_role}' == 'tender_owner'  ${True}  ${False}
    set global variable                                         ${is_test_role_owner}  ${is_test_role_owner}

    register keyword to run on failure                          __private__handle_keyword_failure

set site language by code
    [Arguments]                                                 ${language_code}
    [Documentation]                                             змінити мову сайту

    ${is_equal} =                                               __private__check_site_language_code  ${language_code}
    run keyword if                                              ${is_equal} == ${False}  __private__open_site_language_dropdown_and_select_language_by_code  ${language_code}

login to site
    [Arguments]                                                 ${user_data}
    [Documentation]                                             авторизувати вказаного користувача, масив повинен містити login, password

#    click visible element                                       ${login_popup_open_locator}
#    wait until popup is visible
    open popup by btn locator                                   ${login_popup_open_locator}
    input text to visible input                                 ${login_popup_login_input_locator}  ${user_data['login']}
    input text to visible input                                 ${login_popup_password_input_locator}  ${user_data['password']}
    click visible element                                       ${login_popup_submit_btn_locator}
    wait until page contains element                            ${user_logged_checker_element_locator}  30s  User can not login

fill item form in opened popup
    [Arguments]                                                 ${data}
    [Documentation]                                             заповнює відкриту форму згідно вказаних даних

    ${description} =                                            get from dictionary by keys  ${data}  description
    run keyword if condition is not none                        ${description}  input text to visible input  ${item_form_popup_description_input_locator}  ${description}
    ${description_ru} =                                         get from dictionary by keys  ${data}  description_ru
    run keyword if condition is not none                        ${description_ru}  input text to exist visible input  ${item_form_popup_description_ru_input_locator}  ${description_ru}
    ${description_en} =                                         get from dictionary by keys  ${data}  description_en
    run keyword if condition is not none                        ${description_en}  input text to exist visible input  ${item_form_popup_description_en_input_locator}  ${description_en}
    ${quantity} =                                               get from dictionary by keys  ${data}  quantity
    run keyword and ignore error                                run keyword if condition is not none                        ${quantity}  input number3 to visible input  ${item_form_popup_quantity_input_locator}  ${quantity}
    ${unit} =                                                   get from dictionary by keys  ${data}  unit  name
    run keyword if condition is not none                        ${unit}  select from visible list by label  ${item_form_popup_unit_input_locator}  ${unit}
    ${classification} =                                         get from dictionary by keys  ${data}  classification
    run keyword if condition is not none                        ${classification}  run keyword if  '${mode}' not in 'framework_selection'  select classification by code attributes  ${item_form_popup_classification_edit_btn_locator}  ${classification}
    ${additional_classifications} =                             get from dictionary by keys  ${data}  additionalClassifications
    run keyword if condition is not none                        ${additional_classifications}  run keyword if  '${mode}' not in 'framework_selection'  select classification by array of code attributes  ${item_form_popup_additional_classification_edit_btn_locator}  ${additional_classifications}

get value by locator on opened page
    [Arguments]                                                 ${locator}  ${type}=${None}
    [Documentation]                                             отримує значення з відповідного локатору і якщо потрібно перетворює до відповідного типу

    capture page screenshot
    Run Keyword And Ignore Error    __private__set_element_visible_in_browser_area              ${locator}
    ${value} =                                                  get value by locator  ${locator}
    ${value} =                                                  convert to specified type  ${value}  ${type}
    [Return]                                                    ${value}

get field_value by field_name on opened page
    [Arguments]                                                 ${field_name}
    [Documentation]                                             повертає інформацію з відкритої сторінки, користуючись назвою поля ${field_name}.
    ...                                                         для назви поля повинен бути вказаний відповідний локатор (!вкінці змінної повинно бути слово locator),
    ...                                                         і якщо потрібно тип поля окремою змінною (!locator замінюється на type) зі значенням [string,integer,float]

    ${field_name_prepared} =                                    replace string  ${field_name}  .[  _
    ${field_name_prepared} =                                    replace string  ${field_name_prepared}  ].  _
    ${field_name_prepared} =                                    replace string  ${field_name_prepared}  .  _
    ${field_name_prepared} =                                    replace string  ${field_name_prepared}  [  _
    ${field_name_prepared} =                                    replace string  ${field_name_prepared}  ]  _
    ${field_locator_variable_name} =                            set variable  ${field_name_prepared}_locator
    ${field_type_variable_name} =                               set variable  ${field_name_prepared}_type
    ${field_type_variable_exists} =                             run keyword and return status  variable should exist  ${${field_type_variable_name}}
    ${field_type} =                                             set variable if  ${field_type_variable_exists} == ${True}  ${${field_type_variable_name}}  ${None}
    ${field_locator} =                                          set variable  ${${field_locator_variable_name}}
    ${field_value} =                                            get value by locator on opened page  ${field_locator}  ${field_type}
    [Return]                                                    ${field_value}

########################################################################################################################
#################################################### COMMON HELPERS ####################################################
########################################################################################################################

click visible element
    [Arguments]                                                 ${locator}
    [Documentation]                                             перевіряє видимість і клікає по елементу

    __private__set_element_visible_in_browser_area              ${locator}
    click element                                               ${locator}

click visible element and wait until page contains element
    [Arguments]                                                 ${locator}  ${checker_element_locator}  ${waiting_timeout}=30s  ${waiting_error}=Another element was not shown after clicking on specific element
    [Documentation]                                             перевіряє видимість і клікає по елементу

    click visible element                                       ${locator}
    wait until page contains element                            ${checker_element_locator}  ${waiting_timeout}  ${waiting_error}

click removing form item and wait success result
    [Arguments]                                                 ${locator}
    [Documentation]                                             натискає кнопку видалення, очікує успішне повідомлення і закриває повідомлення

    click visible element                                       ${locator}
    wait until alert is visible
    click visible element                                       ${alert_confirm_btn_locator}
    wait until page does not contain element                    ${alert_confirm_btn_locator}

click removing form feature and wait success result
    [Arguments]                                                 ${locator}
    [Documentation]                                             натискає кнопку видалення нецінового критерію, очікує успішне повідомлення і закриває повідомлення, а потім закриває вікно нецінового критерію

    js click element                                            ${locator}
    wait until alert is visible
    click visible element                                       ${alert_confirm_btn_locator}
    wait until page does not contain element                    ${alert_confirm_btn_locator}
    submit current visible popup

input text to visible input
    [Arguments]                                                 ${locator}  ${text}
    [Documentation]                                             перевіряє чи елемент видимий у вікні браузера, після чого заповнює його

    __private__set_element_visible_in_browser_area              ${locator}
    input text                                                  ${locator}  ${text}

input text to visible input and press enter
    [Arguments]                                                 ${locator}  ${text}
    [Documentation]                                             перевіряє чи елемент видимий у вікні браузера, після чого заповнює його і імітує натиснення кнопки Enter

    input text to visible input                                 ${locator}  ${text}
    press key                                                   ${locator}  \\13

input text to exist visible input
    [Arguments]                                                 ${locator}  ${text}
    [Documentation]                                             перевіряє чи елемент існує і видимий у вікні браузера, після чого заповнює його

    ${input_exists} =                                           get is element exist  ${locator}
    run keyword if                                              ${input_exists} == ${True}  input text to visible input  ${locator}  ${text}
    ...  ELSE                                                   __private__log  input ${locator} does not exist

input date to input
    [Arguments]                                                 ${locator}  ${isodate}  ${format}=%d.%m.%Y

    ${date} =                                                   isodate format  ${isodate}  ${format}
    input text to hidden input                                  ${locator}  ${date}

input datetime to input
    [Arguments]                                                 ${locator}  ${isodate}  ${format}=%d.%m.%Y %H:%M

    input date to input                                         ${locator}  ${isodate}  ${format}

input date to visible input
    [Arguments]                                                 ${locator}  ${isodate}  ${format}=%d.%m.%Y
    [Documentation]                                             перевіряє чи елемент видимий у вікні браузера, після чого заповнює його відформатовоною датою

    __private__set_element_visible_in_browser_area              ${locator}
    input date to input                                         ${locator}  ${isodate}  ${format}

input datetime to visible input
    [Arguments]                                                 ${locator}  ${isodate}  ${format}=%d.%m.%Y %H:%M
    [Documentation]                                             перевіряє чи елемент видимий у вікні браузера, після чого заповнює його відформатовоною датою

    input date to visible input                                 ${locator}  ${isodate}  ${format}

input datetime to exist visible input
    [Arguments]                                                 ${locator}  ${isodate}  ${format}=%d.%m.%Y %H:%M
    [Documentation]                                             перевіряє чи елемент видимий у вікні браузера, після чого заповнює його відформатовоною датою

    ${input_exists} =                                           get is element exist  ${locator}
    run keyword if                                              ${input_exists} == ${True}  input date to visible input  ${locator}  ${isodate}  ${format}
    ...  ELSE                                                   __private__log  input ${locator} does not exist

input number to visible input
    [Arguments]                                                 ${locator}  ${number}
    [Documentation]                                             робить елемент видимим, число перетворює в строку і записує в поле

    ${number} =                                                 convert float to string  ${number}
    input text to visible input                                 ${locator}  ${number}

input number3 to visible input
    [Arguments]                                                 ${locator}  ${number}
    [Documentation]                                             робить елемент видимим, число перетворює в строку і записує в поле

    ${number} =                                                 convert_float_to_string_3f  ${number}
    input text to visible input                                 ${locator}  ${number}

input number to exist visible input
    [Arguments]                                                 ${locator}  ${text}
    [Documentation]                                             перевіряє чи елемент існує і видимий у вікні браузера, після чого заповнює його

    ${input_exists} =                                           get is element exist  ${locator}
    run keyword if                                              ${input_exists} == ${True}  input number to visible input  ${locator}  ${text}
    ...  ELSE                                                   __private__log  input ${locator} does not exist

input month.year of date to visible input
    [Arguments]                                                 ${locator}  ${isodate}
    [Documentation]                                             робить елемент видимим, витягує місяць.рік і записує в поле

    ${value} =                                                  isodate format  ${isodate}  %m.%Y
    input text to visible input                                 ${locator}  ${value}

input to search form and wait results
    [Arguments]                                                 ${query_input_locator}  ${query}  ${result_locator_tpl}
    [Documentation]                                             заповнює форму і очікує результат по шаблону селектора

    input text to visible input and press enter                 ${query_input_locator}  ${query}
    ${result_locator} =                                         replace string  ${result_locator_tpl}  %query%  ${query}
    wait until page contains search                             ${result_locator}
#    wait until page contains element with reloading             ${result_locator}

select from visible list by value
    [Arguments]                                                 ${locator}  ${value}
    [Documentation]                                             робить елемент видимим, після чого заповнює його

    __private__set_element_visible_in_browser_area              ${locator}
    select from list by value                                   ${locator}  ${value}
    trigger input change event                                  ${locator}

select from visible list by label
    [Arguments]                                                 ${locator}  ${label}
    [Documentation]                                             робить елемент видимим, після чого заповнює його

    __private__set_element_visible_in_browser_area              ${locator}
    select from hidden list by label                            ${locator}  ${label}
    trigger input change event                                  ${locator}

select from visible list by year of date
    [Arguments]                                                 ${locator}  ${isodate}
    [Documentation]                                             робить елемент видимим, витягує рік і обирає в списку

    ${value} =                                                  isodate format  ${isodate}  %Y
    select from visible list by value                           ${locator}  ${value}

select classification by code attributes
    [Arguments]                                                 ${btn_locator}  ${code_attributes}
    [Documentation]                                             натискає кнопку відкриття попапу класифікатора і чекає поки він відмалюється, шукає відповідний код і закриває попап

    ${code_attributes_array} =                                  create list  ${code_attributes}
    select classification by array of code attributes           ${btn_locator}  ${code_attributes_array}

select classification by array of code attributes
    [Arguments]                                                 ${btn_locator}  ${code_attributes_array}  ${include_schemes}=${None}  ${exclude_schemes}=${None}
    [Documentation]                                             натискає кнопку відкриття попапу класифікатора і чекає поки він відмалюється, шукає відповідні коди і закриває попап

    ${include_schemes_is_none}=                                 get variable is none  ${include_schemes}
    ${exclude_schemes_is_none}=                                 get variable is none  ${exclude_schemes}

    open popup by btn locator                                   ${btn_locator}  ${classification_popup_opened_content_locator}
    Capture Page Screenshot
    :FOR  ${code_attributes}  IN  @{code_attributes_array}
    \  ${disabled} =                                            set variable if  ${include_schemes_is_none} == ${False} and '${code_attributes['scheme']}' not in ${include_schemes}  ${True}  ${False}
    \  Capture Page Screenshot
    \  ${disabled} =                                            set variable if  ${exclude_schemes_is_none} == ${False} and '${code_attributes['scheme']}' in ${exclude_schemes}  ${True}  ${disabled}
    \  Capture Page Screenshot
    \  run keyword if                                           ${disabled} == ${False}  __private__select_classification_code_in_opened_popup    ${code_attributes['id']}  ${code_attributes['scheme']}
    \  Capture Page Screenshot
    Capture Page Screenshot
    submit current visible popup

open site page and wait content element
    [Arguments]                                                 ${url}  ${waiting_timeout}=5s  ${waiting_error}=Opening page fails
    [Documentation]                                             переходить по посиланню і чекає контенту сторінки

    go to                                                       ${url}
    wait until page contains element                            ${page_content_locator}  ${waiting_timeout}  ${waiting_error}

open page and wait element by locator
    [Arguments]                                                 ${url}  ${waiting_element_locator}  ${waiting_timeout}=5s  ${waiting_error}=Opened page does not have specified element locator
    [Documentation]                                             переходить по посиланню і чекає поки елемент не буде знайдений на сторінці

    go to                                                       ${url}
    wait until page contains element                            ${waiting_element_locator}  ${waiting_timeout}  ${waiting_error}

open popup by btn locator
    [Arguments]                                                 ${btn_locator}  ${popup_locator}=${None}
    [Documentation]                                             натискає кнопку відкриття попапу і чекає поки він відмалюється

    click visible element                                       ${btn_locator}
    ${result} =                                                 run keyword and return status  wait until popup is visible  ${popup_locator}
    run keyword if                                              ${result} == ${False}  js click element  ${btn_locator}
    run keyword if                                              ${result} == ${False}  wait until popup is visible  ${popup_locator}

submit current visible popup
    [Documentation]                                             натискає кнопку сабміту в поточному попапі і чекає поки він закриється

    ${popup_last_id} =                                          __private__get_element_attribute  ${popup_opened_last_locator}  id
    click visible element                                       ${popup_opened_last_submit_btn_locator}
    sleep                                                       ${popup_transaction_time}
    ${popup_last_locator} =                                     set variable  id=${popup_last_id}
    ${popup_exists} =                                           get is element exist  ${popup_last_locator}
    return from keyword if                                      ${popup_exists} == ${False}
    wait until page does not contain element                    ${popup_last_locator}  30s  Current popup was not hidden

submit form and check result
    [Arguments]                                                 ${submit_btn_locator}  ${wait_msg}=${None}  ${wait_element_locator}=${None}  ${sign_is}=${None}  ${plan_is}=${None}
    [Documentation]                                             сабмітить форму і чекає повідомлення (якщо задано) + елемент (якщо задано)

    click visible element                                       ${submit_btn_locator}
    run keyword and ignore error   run keyword if condition is not none                        ${wait_msg}  wait until element is visible  ${tender_cpv_form_submit_success_msg}  5
#    run keyword and ignore error                                Wait Until Page Contains    ${tender_cpv_form_submit_success_msg}   60
    Capture Page Screenshot
    run keyword and ignore error                                execute javascript  ${tender_cpv_js_submit_btn_locator}
    Capture Page Screenshot
#   Ви не зазначили спосіб підтвердження для деяких вимог
    run keyword and ignore error   run keyword if condition is not none                        ${wait_msg}  wait until element is visible  Ви не зазначили спосіб підтвердження для деяких вимог  5
#    run keyword and ignore error                                Wait Until Page Contains    ${tender_cpv_form_submit_success_msg}   60
    Capture Page Screenshot
    run keyword and ignore error                                execute javascript  ${tender_cpv_js_submit_btn_locator}
    Capture Page Screenshot

    run keyword and ignore error                                run keyword if  '${mode}' in 'reporting'  close sync alert  ${tender_form_submit_reporting_success_msg}
    Capture Page Screenshot
###    run keyword and ignore error                                run keyword if condition is not none  ${wait_msg}  Wait Until Page Contains  ${wait_msg}  60
###    Capture Page Screenshot
###    run keyword and ignore error                                run keyword if condition is not none  ${wait_msg}  wait until alert is visible  ${wait_msg}
###    run keyword and ignore error                                run keyword if condition is not none  ${wait_msg}  close current visible alert
###    Capture Page Screenshot
    run keyword and ignore error                                run keyword if  ${plan_is}  wait until alert is visible  ${wait_msg}
    run keyword and ignore error                                run keyword if  ${plan_is}  close current visible alert
    Capture Page Screenshot

###    run keyword and ignore error                                Load Sign

#cat проба
    run keyword and ignore error                                run keyword if  not ${sign_is}  Load Sign
    Capture Page Screenshot
    run keyword and ignore error                                close current visible alert
###    run keyword and ignore error                                run keyword if condition is not none  ${wait_element_locator}  wait until element is visible  ${wait_element_locator}  60
###    run keyword and ignore error                                run keyword if condition is not none  ${wait_element_locator}  wait until page contains element  ${wait_element_locator}  60s  Element was not shown after form submitting

close sync alert
    [Arguments]                                                 ${wait_msg}=${None}
    [Documentation]                                             чекає поки попап не стане видимим на сторінці

    ${status}=                                                  run keyword if  '${mode}' in 'openeu open_competitive_dialogue openua_defense open_esco open_framework'  Run Keyword And Return Status  Page Should Contain  ${wait_msg}
    run keyword and ignore error                                run keyword if  ${status} and '${mode}' in 'openeu open_competitive_dialogue openua_defense open_esco open_framework'  Wait Until Page Contains  ${wait_msg}  60
    run keyword and ignore error                                run keyword if  ${status} and '${mode}' in 'openeu open_competitive_dialogue openua_defense open_esco open_framework'  wait until alert is visible  ${wait_msg}
    run keyword and ignore error                                run keyword if  ${status} and '${mode}' in 'openeu open_competitive_dialogue openua_defense open_esco open_framework'  close current visible alert


wait until popup is visible
    [Arguments]                                                 ${popup_locator}=${None}  ${waiting_timeout}=30s  ${waiting_error}=Opened popup still not visible
    [Documentation]                                             чекає поки попап не стане видимим на сторінці

    ${popup_locator_is_none} =                                  get variable is none  ${popup_locator}
    ${popup_locator} =                                          set variable if  ${popup_locator_is_none} == ${False}  ${popup_locator}  ${popup_opened_content_locator}
    ${status} =                                                 run keyword and return status  wait until element is visible  ${popup_locator}  ${waiting_timeout}  ${waiting_error}
    # trying to prevent "StaleElementReferenceException: Message: stale element reference: element is not attached to the page document" error
    run keyword if                                              ${status} == ${False}  sleep  1
    run keyword if                                              ${status} == ${False}  wait until element is visible  ${popup_locator}  1  ${waiting_error}

wait until alert is visible
    [Arguments]                                                 ${message}=${None}
    [Documentation]                                             чекає поки не з'явиться алерт

    ${message_is_none} =                                        get variable is none  ${message}
    ${message} =                                                convert to string  ${message}
    ${alert_message_locator} =                                  replace string  ${alert_message_contains_text_locator_tpl}  %text%  ${message}
    run keyword if                                              ${message_is_none} == ${True}  wait until page contains element  ${alert_opened_locator}  60s  Alert was not shown
    run keyword if                                              ${message_is_none} == ${False}  wait until page contains element  ${alert_message_locator}  60s  Alert was not shown

    # wait for ending animation
    sleep                                                       500ms

close current visible alert
    [Documentation]                                             закриває поточний alert

    click visible element                                       ${alert_opened_close_btn_locator}

    # wait for ending animation
    sleep                                                       500ms

wait until page contains search
    [Arguments]                                                 ${locator}  ${retry}=5m  ${retry_interval}=2s
    [Documentation]                                             чекає поки елемент не з'явиться на сторінці з перезапуском пошуку

    ${result} =                                                 get is element exist  ${locator}
    capture page screenshot
    run keyword if                                              ${result} == ${False}  wait until keyword succeeds  ${retry}  ${retry_interval}  reload page and fail if element does not exist on search  ${locator}

wait until page contains element with reloading
    [Arguments]                                                 ${locator}  ${retry}=5m  ${retry_interval}=2s
    [Documentation]                                             чекає поки елемент не з'явиться на сторінці з перезавантаженням сторінки

    ${result} =                                                 get is element exist  ${locator}
    run keyword if                                              ${result} == ${False}  wait until keyword succeeds  ${retry}  ${retry_interval}  reload page and fail if element does not exist  ${locator}

wait until page does not contain element with reloading
    [Arguments]                                                 ${locator}  ${retry}=5m  ${retry_interval}=2s
    [Documentation]                                             чекає поки елемент не пропаде зі сторінки з перезавантаженням сторінки

    ${result} =                                                 get is element exist  ${locator}
    run keyword if                                              ${result} == ${True}  wait until keyword succeeds  ${retry}  ${retry_interval}  reload page and fail if element exists  ${locator}
    capture page screenshot

wait until tab content is visible
    [Arguments]                                                 ${tab_link}  ${waiting_timeout}=30s  ${waiting_error}=Opened tab still not visible
    [Documentation]                                             чекає поки контент вказаного табу не буде видимим

    ${tab_link_href} =                                          __private__get_element_attribute  ${tab_link}  href
    ${tab_content_locator} =                                    set variable  jquery=${tab_link_href}
    wait until element is visible                               ${tab_content_locator}  ${waiting_timeout}  ${waiting_error}

reload page and fail if element exists
    [Arguments]                                                 ${locator}
    [Documentation]                                             перезавантажує сторінку і фейлить тест якщо елемент присутній

    capture page screenshot
    reload page
    capture page screenshot
    ${exists} =                                                 get is element exist  ${locator}
    run keyword if                                              ${exists} == ${True}  fail

reload page and fail if element does not exist
    [Arguments]                                                 ${locator}
    [Documentation]                                             перезавантажує сторінку і фейлить тест якщо елемент відсутній

    reload page
    capture page screenshot
    ${exists} =                                                 get is element exist  ${locator}
    run keyword if                                              ${exists} == ${False}  fail

reload page and fail if element does not exist on search
    [Arguments]                                                 ${locator}
    [Documentation]                                             перезавантажує сторінку і фейлить тест якщо елемент відсутній в пошуку

    click visible element                                       ${tender_form_search_btn_locator}
    ${exists} =                                                 get is element exist  ${locator}
    run keyword if                                              ${exists} == ${False}  fail

get is 404 page
    [Documentation]                                             перевіряє чи поточна сторінка з 404 помилкою

    ${exists} =                                                 get is element exist  ${error_page_404_checker_element_locator}
    [Return]                                                    ${exists}

wait until 404 page disappears
    [Arguments]                                                 ${retry}=5m  ${retry_interval}=2s
    [Documentation]                                             оновлює сторінку і чекає поки не пропаде 404 помилка

    ${result} =                                                 get is 404 page
    run keyword if                                              ${result} == ${True}  wait until keyword succeeds  ${retry}  ${retry_interval}  reload page and fail if element exists  ${error_page_404_checker_element_locator}

########################################################################################################################
################################################### PRIVATE KEYWORDS ###################################################
########################################################################################################################

__private__handle_keyword_failure
    [Documentation]                                             обробка падіння тесту, збір можливої інформації для аналізу проблеми

    capture page screenshot
    ${form_errors} =                                            __private__get_all_form_errors
    log dictionary                                              ${form_errors}

__private__get_all_form_errors
    [Documentation]                                             збирає всі помилки форм на сторінці

    ${errors} =                                                 execute javascript
    ...                                                         var errors = {};
    ...                                                         $('.has-error .help-block-error').each(function () {
	...                                                             var cssClass = $(this).attr('class'), text = $(this).text();
	...                                                             cssClass = cssClass.replace("help-block-error", "");
	...                                                             cssClass = cssClass.replace("help-block", "");
	...                                                             errors[cssClass] = text;
    ...                                                         });
    ...                                                         return errors;
    [Return]                                                    ${errors}

__private__log
    [Arguments]                                                 ${msg}
    [Documentation]                                             пише в логи

    log                                                         ${msg}
    log to console                                              ${msg}

__private__get_element_attribute
    [Arguments]                                                 ${locator}  ${attribute}
    [Documentation]                                             повертає значення атрибуту для вказаного елементу

    ${value} =                                                  get element attribute  ${locator}@${attribute}
    [Return]                                                    ${value}

__private__set_element_visible_in_browser_area
    [Arguments]                                                 ${locator}
    [Documentation]                                             робить елемент видимим у вікні браузера

    set element scroll into view                                ${locator}

__private__get_site_language_code
    [Documentation]                                             повертає код поточної мови сайта

    ${current_language_code} =                                  __private__get_element_attribute  ${language_selector_active_element_locator}  ${language_selector_active_element_code_attribute_name}
    [Return]                                                    ${current_language_code}

__private__check_site_language_code
    [Arguments]                                                 ${language_code}
    [Documentation]                                             повертає чи поточна мова сайту відповідає вказаній

    ${current_language_code} =                                  __private__get_site_language_code
    ${is_equal} =                                               set variable if  "${current_language_code}" == "${language_code}"  ${True}  ${False}
    [Return]                                                    ${is_equal}

__private__open_site_language_dropdown_and_select_language_by_code
    [Arguments]                                                 ${language_code}
    [Documentation]                                             відкриває випадаючий список мов, обрає потрібну, чекає перезавантаження сторінки

    click visible element                                       ${language_selector_open_element_locator}
    ${language_selector_list_element_locator} =                 replace string  ${language_selector_list_element_locator_tpl}  %code%  ${language_code}
    click element                                               ${language_selector_list_element_locator}
    ${language_selector_active_element_locator} =               replace string  ${language_selector_active_element_by_code_locator_tpl}  %code%  ${language_code}
    wait until page contains element                            ${language_selector_active_element_locator}  30s  Language have not changed

__private__select_classification_code_in_opened_popup
    [Arguments]                                                 ${code}  ${scheme}=${None}
    [Documentation]                                             в поточний попап з класифікатором перемикає схему, шукає заданий код в полі пошуку і обирає його

    # check scheme
    ${scheme_is_none} =                                         get variable is none  ${scheme}
    ${scheme} =                                                 convert to string  ${scheme}
    run keyword if                                              ${scheme_is_none} == ${False} and '${scheme}' not in ${site_allowed_schemes}  __private__log  Scheme "${scheme}" is needed to implement.
    return from keyword if                                      ${scheme_is_none} == ${False} and '${scheme}' not in ${site_allowed_schemes}
    ${scheme_tab_locator} =                                     replace string  ${classification_popup_scheme_tab_locator_tpl}  %scheme%  ${scheme}
    ${scheme_tab_exists} =                                      get is element exist  ${scheme_tab_locator}
    run keyword if                                              ${scheme_tab_exists} == ${True}  click visible element  ${scheme_tab_locator}
    run keyword if                                              ${scheme_tab_exists} == ${True}  wait until tab content is visible  ${scheme_tab_locator}
    ...  ELSE                                                   __private__log  Classification scheme tab ${scheme} does not exist
    # seraching code
    input text to visible input and press enter                 ${classification_popup_search_input_locator}  ${code}
    ${code} =                                                   convert to string  ${code}
    ${code_item_locator} =                                      replace string  ${classification_popup_serach_item_locator_tpl}  %code%  ${code}
    wait until page contains element                            ${code_item_locator}  90s  Specified classification code was not found
    click visible element                                       ${code_item_locator}

Load Sign
    run keyword and ignore error                                click visible element                                    ${plan_form_ecp_btn_locator}                                
    ${loadingfakeKey} =                                         Run keyword And Return Status  Wait Until Page Contains   Це фейкове накладання ЕЦП   30
    run keyword and ignore error                                Run Keyword If  ${loadingfakeKey} == True  submit form and check result  id=SignDataButton  ${qualification_ecp_form_submit_success_msg}
    ${loadingKey} =                                             Run keyword And Return Status  Wait Until Page Contains   Серійний номер   30
    Run Keyword If                                              ${loadingfakeKey} == True  Fail   Далі не ходити
    Run Keyword If                                              ${loadingKey} == False  Load Sign Data
    Wait Until Page Contains                                    Серійний номер   60
    submit form and check result                                id=SignDataButton  ${qualification_ecp_form_submit_success_msg}

Load Sign Data
    Wait Until Page Contains Element   id=CAsServersSelect   60
    Select From List By Label   id=CAsServersSelect     Тестовий ЦСК АТ "ІІТ"
    Wait Until Page Contains Element  id=PKeyFileName  60
    Choose File   id=PKeyFileInput     ${CURDIR}/Key-6.dat
    Wait Until Page Contains Element  id=PKeyPassword  60
    Input Text    id=PKeyPassword     12345677
    Wait Until Page Contains Element  id=PKeyReadButton  60
    Click Element   id=PKeyReadButton

GetDictionaryKeyExist
    [Arguments]                                                 ${Dictionary Name}  ${Key}
    Run Keyword And Return Status       Dictionary Should Contain Key       ${Dictionary Name}      ${Key}

GetValueFromDictionaryByKey      [Arguments]     ${Dictionary Name}      ${Key}
  ${KeyIsPresent}=    Run Keyword And Return Status       Dictionary Should Contain Key       ${Dictionary Name}      ${Key}
  ${Value}=           Run Keyword If      ${KeyIsPresent}     Get From Dictionary             ${Dictionary Name}      ${Key}
  Return From Keyword         ${Value}

