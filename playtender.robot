*** Settings ***

Resource                                                        playtender_common.robot
Resource                                                        playtender_plan.robot
Resource                                                        playtender_tender.robot
Resource                                                        playtender_qualification.robot
Resource                                                        playtender_contract.robot

*** Variables ***

*** Keywords ***

Підготувати клієнт для користувача
    [Arguments]                                                 ${username}
    [Documentation]                                             Відкриває переглядач на потрібній сторінці, готує api wrapper, тощо.

    init environment                                            ${username}
    open browser                                                ${broker_baseurl}  ${broker_browser}  alias=${broker_username}
    add cookie                                                  robottest  1  # for detecting from site side
    set window size                                             @{browser_default_size}
    set window position                                         @{browser_default_position}
    set site language by code                                   ${broker_language_code}
    login to site                                               ${USERS.users['${broker_username}']}

Підготувати дані для оголошення тендера
    [Arguments]                                                 ${username}  ${tender_data}  ${role_name}
    [Documentation]                                             Адаптувати початкові дані для створення тендера. Наприклад, змінити дані про procuringEntity на дані
    ...                                                         про користувача tender_owner на майданчику. Перевіряючи значення аргументу role_name, можна адаптувати
    ...                                                         різні дані для різних ролей (наприклад, необхідно тільки для ролі tender_owner забрати з початкових
    ...                                                         даних поле mode: test, а для інших ролей не потрібно робити нічого). Це ключове слово викликається в
    ...                                                         циклі для кожної ролі, яка бере участь в поточному сценарії. З ключового слова потрібно повернути
    ...                                                         адаптовані дані tender_data. Різниця між початковими даними і кінцевими буде виведена в консоль під
    ...                                                         час запуску тесту.

    ${tender_data_keys} =                                       get dictionary keys  ${tender_data['data']}
    run keyword if                                              ${is_test_role_owner} and 'procuringEntity' in ${tender_data_keys}  prepare procuring entity data  ${tender_data['data']['procuringEntity']}
    #run keyword if                                              ${is_test_role_owner} and 'buyers' in ${tender_data_keys}  prepare buyers data  ${tender_data['data']['buyers']}
    [Return]                                                    ${tender_data}

########################################################################################################################
#################################################### PLAN KEYWORDS #####################################################
########################################################################################################################

Створити план
    [Arguments]                                                 ${user}  ${plan_data}
    [Documentation]                                             Створити план з початковими даними plan_data. Повернути uaid створеного плану.

    # check buyers
    ${buyers_count} =                                           get length  ${plan_data['data']['buyers']}
    run keyword if                                              ${buyers_count} != 1  fail  Buyer must be one

    open new plan form
    fill plan form                                              ${plan_data['data']}
    save plan form and wait synchronization
    ${plan_uaid} =                                              get text  ${plan_uaid_text_locator}
    [Return]                                                    ${plan_uaid}

Оновити сторінку з планом
    [Arguments]                                                 ${username}  ${plan_uaid}
    [Documentation]                                             Оновити сторінку з планом для отримання потенційно оновлених даних.

    open plan page by uaid                                      ${plan_uaid}

Пошук плану по ідентифікатору
    [Arguments]                                                 ${username}  ${plan_uaid}
    [Documentation]                                             Знайти план за зазначеним plan_uaid.

    open plan search form
    input to search form and wait results                       ${plan_search_form_query_input_locator}  ${plan_uaid}  ${plan_search_form_result_locator_tpl}

Внести зміни в план
    [Arguments]                                                 ${username}  ${plan_uaid}  ${fieldname}  ${fieldvalue}
    [Documentation]                                             Змінити значення поля fieldname на fieldvalue для плана із зазначеним plan_uaid.

    ${plan_data} =                                              generate dictionary from field path and value  ${fieldname}  ${fieldvalue}
    open plan form by uaid                                      ${plan_uaid}
    fill plan form                                              ${plan_data}
    save plan form and wait synchronization

Додати предмет закупівлі в план
    [Arguments]                                                 ${username}  ${plan_uaid}  ${item_data}
    [Documentation]                                             Додати дані про предмет item до плану plan_uaid.

    open plan form by uaid                                      ${plan_uaid}
    ${items} =                                                  create list  ${item_data}
    fill plan form items                                        ${items}
    save plan form and wait synchronization

Видалити предмет закупівлі плану
    [Arguments]                                                 ${username}  ${plan_uaid}  ${item_id}
    [Documentation]                                             Видалити з плану plan_uaid предмет з item_id в описі.

    open plan form by uaid                                      ${plan_uaid}
    ${delete_item_btn_locator} =                                replace string  ${plan_form_remove_item_btn_locator_tpl}  %title%  ${item_id}
    click removing form item and wait success result            ${delete_item_btn_locator}
    save plan form and wait synchronization

Отримати інформацію із плану
    [Arguments]                                                 ${username}  ${plan_uaid}  ${field_name}
    [Documentation]                                             Отримати інформацію із плану, користуючись ідентіфікатором плану та назвою поля ${field_name}.

    open plan page by uaid                                      ${plan_uaid}  ${False}
    ${field_name} =                                             set variable  plan.${field_name}.value
    ${value} =                                                  get field_value by field_name on opened page  ${field_name}
    [Return]                                                    ${value}

########################################################################################################################
################################################### TENDER KEYWORDS ####################################################
########################################################################################################################

Створити тендер
    [Arguments]                                                 ${user}  ${tender_data}
    [Documentation]                                             Створити тендер з початковими даними tender_data. Повернути
    ...                                                         uaid створеного тендера.

    ${tender_prepared_data} =                                   prepare tender data  ${tender_data['data']}
    ##### BOF - TMP for negotiation milestone 1 lot#####
    Set Global Variable    ${td_railway_crutch}  ${tender_data}
    ##### EOF - TMP #####

    ${tender_data_keys}=  Get Dictionary Keys  ${tender_data.data}
    ${procurementMethodType} =  Set Variable If  'procurementMethodType' in ${tender_data_keys}  ${tender_data.data.procurementMethodType}  belowThreshold
    Run Keyword If  '${SUITE_NAME}' == 'Tests Files.Complaints' and '${procurementMethodType}' == 'aboveThresholdUA'  Go To  ${BROKERS['playtender'].basepage}/utils/config?tacceleration=1000
    Run Keyword If  '${SUITE_NAME}' == 'Tests Files.Complaints' and '${procurementMethodType}' == 'belowThreshold'  Go To  ${BROKERS['playtender'].basepage}/utils/config?tacceleration=720
    open new tender form
    fill tender form                                            ${tender_prepared_data}
    submit form and check result                                ${tender_form_submit_btn_locator}  ${tender_form_submit_success_msg}  ${tender_created_checker_element_locator}
    wait until page does not contain element with reloading     ${tender_sync_element_locator}
    wait until page contains element with reloading             ${tender_uaid_text_locator}
    ${tender_uaid} =                                            get text  ${tender_uaid_text_locator}
    [Return]                                                    ${tender_uaid}

Оновити сторінку з тендером
    [Arguments]                                                 ${username}  ${$tender_uaid}
    [Documentation]                                             Оновити сторінку з тендером для отримання потенційно оновлених даних.

    Selenium2Library.Switch Browser                             ${username}
    open tender page by uaid                                    ${$tender_uaid}

Пошук тендера по ідентифікатору
    [Arguments]                                                 ${username}  ${tender_uaid}  ${save_key}=${Empty}
    [Documentation]                                             Знайти тендер з uaid рівним tender_uaid.

    open tender search form
    input to search form and wait results                       ${tender_search_form_query_input_locator}  ${tender_uaid}  ${tender_search_form_result_locator_tpl}

Отримати інформацію із тендера
    [Arguments]                                                 ${username}  ${tender_uaid}  ${field_name}
    [Documentation]                                             Отримати значення поля field_name для тендера tender_uaid.

    # fix for preventing error "Resolving variable '${award.value.amount}' failed: AttributeError: value" in next keywords for owner role
    #run keyword if                                              ${is_test_role_owner} and '${field_name}' in 'awards[0].complaintPeriod.endDate awards[1].complaintPeriod.endDate awards[2].complaintPeriod.endDate awards[3].complaintPeriod.endDate'  fix awards data in global Users variable  ${username}

    open tender page by uaid                                    ${tender_uaid}
    Run Keyword And Return If                                   '${field_name}' == 'complaintPeriod.endDate'   Отримати інформацію із complaintPeriod.endDate
    Run Keyword And Return If                                   '${field_name}' == 'items[0].deliveryLocation.latitude'   Fail   Поле не відображаем
    run keyword if                                              '${field_name}' == 'status'  wait for tender status
    run keyword if                                              '${field_name}' == 'agreements[0].status'  Wait Until Keyword Succeeds    1600 s    20 s    wait for agreements status active
    run keyword if                                              '${field_name}' == 'qualificationPeriod.endDate'  Wait Until Keyword Succeeds    1600 s    20 s    Wait For QualificationsPeriodEnd
    Run Keyword And Return If                                   '${field_name}' == 'contracts[0].status' or '${field_name}' == 'contracts[1].status'   Отримати інформацію із contracts[0].status
    Run Keyword And Return If                                   '${field_name}' == 'qualificationPeriod.endDate' and '${mode}' in 'open_competitive_dialogue'   Отримати інформацію із qualificationPeriod.endDate
    Run Keyword And Return If                                   '${field_name}' in 'awards[0].complaintPeriod.endDate awards[1].complaintPeriod.endDate awards[2].complaintPeriod.endDate awards[3].complaintPeriod.endDate'   Отримати інформацію із awards.complaintPeriod.endDate
    Run Keyword And Return If                                   '${field_name}' in 'minimalStep.amount'   Отримати інформацію із minimalStep.amount
    Run Keyword And Return If                                   '${field_name}' == 'awards[0].documents[0].title'   Отримати інформацію із awards[0].documents[0].title
    ${field_name} =                                             set variable  tender.${field_name}.value
    ${value} =                                                  get field_value by field_name on opened page  ${field_name}
    [Return]                                                    ${value}

Внести зміни в тендер
    [Arguments]                                                 ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
    [Documentation]                                             Змінити значення поля fieldname на fieldvalue для плана із зазначеним plan_uaid.

    ${tender_data} =                                            generate dictionary from field path and value  ${fieldname}  ${fieldvalue}
    open tender form by uaid                                    ${tender_uaid}
    fill tender form                                            ${tender_data}
    save tender form and wait synchronization

Завантажити документ
    [Arguments]                                                 ${username}  ${filepath}  ${tender_uaid}
    [Documentation]                                             Завантажити документ, який знаходиться по шляху filepath,
    ...                                                         до тендера tender_uaid.

    open tender form by uaid                                    ${tender_uaid}
    add document in tender                                      ${filepath}
    save tender form and wait synchronization

########################################################################################################################
################################################### ITEM KEYWORDS ####################################################
########################################################################################################################

Додати предмет закупівлі
    [Arguments]                                                 ${username}  ${tender_uaid}  ${item_data}
    [Documentation]                                             Додати дані про предмет item до тендера tender_uaid.

    open tender form by uaid                                    ${tender_uaid}
    ${items} =                                                  create list  ${item_data}
    fill tender form items                                      ${items}
    save tender form and wait synchronization

Отримати інформацію із предмету
    [Arguments]                                                 ${username}  ${tender_uaid}  ${item_id}  ${field_name}
    [Documentation]                                             Отримати значення поля field_name з предмету з item_id в описі для тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}
    #перейти на соответствующий предмет в первом лоте, например, первый
    run keyword and ignore error                                click visible element  ${tender_lot_1_tabs_item_btn_locator}
    ${return_value} =                                           get value from item  ${item_id}  ${field_name}
    [return]                                                    ${return_value}

Видалити предмет закупівлі
    [Arguments]                                                 ${username}  ${tender_uaid}  ${item_id}  ${lot_id}=Empty
    [Documentation]                                             Видалити з тендера tender_uaid предмет з item_id в описі
    ...                                                         (предмет може бути прив'язаним до лоту з lot_id в описі,
    ...                                                         якщо lot_id != Empty).

    open tender form by uaid                                    ${tender_uaid}
    wait until page does not contain element with reloading     ${tender_sync_element_locator}
    ${tender_form_lots_remove_item_btn_locator} =               replace string  ${tender_form_lots_remove_item_btn_locator_tpl}  %item_id%  ${item_id}
    wait until page contains element with reloading             ${tender_form_lots_remove_item_btn_locator}
    click visible element                                       ${tender_form_lots_remove_item_btn_locator}
    Wait Until Page Contains                                    ${tender_lots_remove_item_form_submit_success_msg}  60
    execute javascript                                          ${not_alert_opened_close_btn_locator}
    #run keyword and ignore error  click visible element                                       ${not_alert_opened_close_btn_locator}
    capture page screenshot
    Wait Until Page Does Not Contain                            ${tender_lots_remove_item_form_submit_success_msg}  10
    capture page screenshot

    save tender form and wait synchronization


########################################################################################################################
################################################### END ITEM KEYWORDS #################################################
########################################################################################################################

########################################################################################################################
################################################### LOT KEYWORDS ####################################################
########################################################################################################################

Створити лот
    [Arguments]                                                 ${username}  ${tender_uaid}  ${lot}
    [Documentation]                                             Додати лот lot до тендера tender_uaid.

Отримати інформацію із лоту
    [Arguments]                                                 ${username}  ${tender_uaid}  ${lot_id}  ${field_name}
    [Documentation]                                             Отримати значення поля field_name з лоту з lot_id в описі для тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}
    #перейти на соответствующий лот, например, первый
    ${tender_lot_switch_tabs_lot_btn_locator} =                 replace string  ${tender_lot_switch_tabs_lot_btn_locator_tpl}  %lot_id%  ${lot_id}
    click visible element                                       ${tender_lot_switch_tabs_lot_btn_locator}
#    ${field_name} =                                             set variable  tender.lot.${field_name}.value
    ${value} =                                                  get value from lot  ${lot_id}  ${field_name}
#    ${value} =                                                  get field_value by field_name on opened page  ${field_name}
    [Return]                                                    ${value}

Завантажити документ в лот
    [Arguments]                                                 ${username}  ${filepath}  ${tender_uaid}  ${lot_id}
    [Documentation]                                             Завантажити документ, який знаходиться по шляху filepath,
    ...                                                         до лоту з lot_id в описі для тендера tender_uaid.

    open tender form by uaid                                    ${tender_uaid}
    add document in lot                                         ${filepath}  ${lot_id}
    save tender form and wait synchronization

Змінити лот
    [Arguments]                                                 ${username}  ${tender_uaid}  ${lot_id}  ${fieldname}  ${fieldvalue}
    [Documentation]                                             Змінити значення поля fieldname лоту з lot_id в описі
    ...                                                         для тендера tender_uaid на fieldvalue.

    ${tender_data} =                                            generate dictionary from field path and value  ${fieldname}  ${fieldvalue}
    open tender form by uaid                                    ${tender_uaid}
    #выбор нужного лота
    click visible element                                       ${tender_form_lots_edit_lot1_btn_locator}
    wait until popup is visible
    fill lot form in opened popup                               ${tender_data}
    submit current visible popup
    save tender form and wait synchronization

Додати предмет закупівлі в лот
    [Arguments]                                                 ${username}  ${tender_uaid}  ${lot_id}  ${item}
    [Documentation]                                             Додати предмет item в лот з lot_id в описі для тендера tender_uaid.

    open tender form by uaid                                    ${tender_uaid}
#    click visible element                                       ${tender_form_lots_add_item_btn_locator}
    ${items} =                                                  create list  ${item}
    fill tender form items                                      ${items}
#    wait until popup is visible
#    fill tender item form in opened popup                                      ${item}
#    submit current visible popup
    save tender form and wait synchronization


########################################################################################################################
################################################### END LOT KEYWORDS #################################################
########################################################################################################################
########################################################################################################################
################################################### FEATIRE KEYWORDS #############################################
########################################################################################################################

Додати неціновий показник на тендер
    [Arguments]                                                 ${username}  ${tender_uaid}  ${feature}
    [Documentation]                                             Додати дані feature про неціновий показник до тендера tender_uaid.

    open tender form by uaid                                    ${tender_uaid}
    ${features} =                                               create list  ${feature}
    fill tender form features                                   ${features}  ${tender_update_feature_tender_btn_locator}
    #fill tender form features2                                  ${feature}  ${tender_update_feature_tender_btn_locator}
    save tender form and wait synchronization

Додати неціновий показник на предмет
    [Arguments]                                                 ${username}  ${tender_uaid}  ${feature}  ${item_id}
    [Documentation]                                             Додати дані feature про неціновий показник до предмету з item_id в описі для тендера tender_uaid.

    open tender form by uaid                                    ${tender_uaid}
    ${features} =                                               create list  ${feature}
    fill tender form features                                   ${features}  ${tender_form_item_add_feature_btn_locator}
#    fill tender form features2                                  ${feature}  ${tender_form_item_add_feature_btn_locator}
    save tender form and wait synchronization

Додати неціновий показник на лот
    [Arguments]                                                 ${username}  ${tender_uaid}  ${feature}  ${lot_id}
    [Documentation]                                             Додати дані feature про неціновий показник до лоту з lot_id в описі для тендера tender_uaid.

    open tender form by uaid                                    ${tender_uaid}
#    click visible element                                       ${tender_update_feature_lot_btn_locator}
    ${features} =                                               create list  ${feature}
    fill tender form features                                   ${features}  ${tender_update_feature_lot_btn_locator}
#    fill tender form features2                                  ${feature}  ${tender_update_feature_lot_btn_locator}
    save tender form and wait synchronization

Отримати інформацію із нецінового показника
    [Arguments]                                                 ${username}  ${tender_uaid}  ${feature_id}  ${field_name}
    [Documentation]                                             Отримати значення поля field_name з нецінового показника з feature_id в описі для тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}
    wait until page does not contain element with reloading     ${tender_sync_element_locator}
    ${return_value} =                                           get value from features  ${feature_id}  ${field_name}
    [return]                                                    ${return_value}

Видалити неціновий показник
    [Arguments]                                                 ${username}  ${tender_uaid}  ${feature_id}  ${obj_id}=Empty
    [Documentation]                                             Видалити неціновий показник з feature_id в описі для тендера tender_uaid.

    open tender form by uaid                                    ${tender_uaid}
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість видалити неціновий показник на предмет'    click visible element   ${tender_update_feature_item_btn_locator}
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість видалити неціновий показник на лот'    click visible element   ${tender_update_feature_lot_btn_locator}
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість видалити неціновий показник на тендер'    click visible element   ${tender_update_feature_tender_btn_locator}
    wait until popup is visible
    ${tender_feature_switch_dell_btn_locator} =                 replace string  ${tender_feature_switch_dell_btn_locator_tpl}  %feature_id%  ${feature_id}
    execute javascript                                          ${tender_feature_switch_dell_btn_locator}
#    click visible element                                       ${tender_feature_switch_dell_btn_locator}
    Wait Until Element Is Visible                               ${tender_feature_dell_btn_locator}  20
    click visible element                                       ${tender_feature_dell_btn_locator}
    Wait Until Page Contains                                    ${tender_feature_form_submit_success_msg}  60
    execute javascript                                          ${not_alert_opened_close_btn_locator}
    #click visible element                                       ${not_alert_opened_close_btn_locator}
    Wait Until Page Does Not Contain                            ${tender_feature_form_submit_success_msg}  10
    submit current visible popup
    save tender form and wait synchronization


########################################################################################################################
################################################### END FEATIRE KEYWORDS #############################################
########################################################################################################################

########################################################################################################################
################################################### QUESTION KEYWORDS #############################################
########################################################################################################################

Відповісти на запитання
    [Arguments]                                                 ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
    [Documentation]                                             Дати відповідь answer_data на запитання з question_id
    ...                                                         в описі для тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}
    answer question                                             ${answer_data}  ${question_id}

Задати запитання на предмет
    [Arguments]                                                 ${username}  ${tender_uaid}  ${item_id}  ${question}
    [Documentation]                                             Створити запитання з даними question до предмету з item_id
    ...                                                         в описі для тендера tender_uaid.

    add question                                                ${username}  ${tender_uaid}  item  ${item_id}  ${question}

Задати запитання на лот
    [Arguments]                                                 ${username}  ${tender_uaid}  ${lot_id}  ${question}
    [Documentation]                                             Створити запитання з даними question до лоту з lot_id
    ...                                                         в описі для тендера tender_uaid.

    add question                                                ${username}  ${tender_uaid}  lot  ${lot_id}  ${question}

Задати запитання на тендер
    [Arguments]                                                 ${username}  ${tender_uaid}  ${question}
    [Documentation]                                             Створити запитання з даними question для тендера tender_uaid.

    add question                                                ${username}  ${tender_uaid}  tender  null  ${question}

Отримати інформацію із запитання
    [Arguments]                                                 ${username}  ${tender_uaid}  ${question_id}  ${field_name}
    [Documentation]                                             Отримати значення поля field_name із запитання з question_id
    ...                                                         в описі для тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}
    ${value} =                                                  get question information  ${question_id}  ${field_name}
    [Return]                                                    ${value}


########################################################################################################################
################################################### END QUESTION KEYWORDS #############################################
########################################################################################################################

########################################################################################################################
################################################### CLAIM KEYWORDS #############################################
########################################################################################################################
Створити вимогу про виправлення умов закупівлі
    [Arguments]                                                 ${username}  ${tender_uaid}  ${claim}  ${doc_name}
    [Documentation]                                             Створити запитання з даними question для тендера tender_uaid.

    Run Keyword And Return                                      Створити вимогу  ${username}  ${tender_uaid}  tender  null  ${claim}  ${doc_name}

Створити чернетку вимоги про виправлення умов закупівлі
    [Arguments]                                                 ${username}  ${tender_uaid}  ${claim}
    [Documentation]                                             Створює вимогу claim про виправлення умов закупівлі
    ...                                                         у статусі claim для тендера tender_uaid. Можна створити
    ...                                                         вимогу як з документом, який знаходиться за шляхом document,
    ...                                                         так і без нього.

    Run Keyword And Return                                      Створити вимогу  ${username}  ${tender_uaid}  tender  null  ${claim}  null

Створити вимогу про виправлення умов лоту
    [Arguments]                                                 ${username}  ${tender_uaid}  ${claim}  ${lot_id}  ${doc_name}
    [Documentation]                                             Створює вимогу claim про виправлення умов лоту
    ...                                                         у статусі draft для тендера tender_uaid.

    Run Keyword And Return                                      Створити вимогу  ${username}  ${tender_uaid}  lot  ${lot_id}  ${claim}  ${doc_name}

Створити чернетку вимоги про виправлення умов лоту
    [Arguments]                                                 ${username}  ${tender_uaid}  ${claim}  ${lot_id}
    [Documentation]                                             Створює вимогу claim про виправлення умов закупівлі
    ...                                                         у статусі draft для тендера tender_uaid.

    Run Keyword And Return                                      Створити вимогу  ${username}  ${tender_uaid}  lot  ${lot_id}  ${claim}  null

Створити вимогу про виправлення визначення переможця
    [Arguments]                                                 ${username}  ${tender_uaid}  ${claim}  ${proposal_id}  ${doc_name}
    [Documentation]                                             Створює вимогу claim про виправлення визначення переможця
    ...                                                         під номером award_index в статусі claim для тендера tender_uaid. Можна створити вимогу як з документом, який знаходиться за шляхом document, так і без нього.

    Run Keyword And Return                                      Створити вимогу  ${username}  ${tender_uaid}  winner  ${proposal_id}  ${claim}  ${doc_name}

Створити чернетку вимоги про виправлення визначення переможця
    [Arguments]                                                 ${username}  ${tender_uaid}  ${claim}  ${proposal_id}
    [Documentation]                                             Створює вимогу claim про виправлення визначення переможця
    ...                                                         під номером award_index в статусі draft для тендера tender_uaid.

    Run Keyword And Return                                      Створити вимогу  ${username}  ${tender_uaid}  winner  ${proposal_id}  ${claim}  null

Створити скаргу про виправлення визначення переможця
    [Arguments]                                                 ${username}  ${tender_uaid}  ${claim}  ${proposal_id}  ${doc_name}
    [Documentation]                                             Створює скаргу claim про виправлення визначення переможця
    ...                                                         під номером proposal_id в статусі claim для тендера tender_uaid.

    Run Keyword And Return                                        Створити вимогу  ${username}  ${tender_uaid}  winner_complaint  ${proposal_id}  ${claim}  ${doc_name}


Скасувати вимогу про виправлення умов закупівлі
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}
    [Documentation]                                             Перевести вимогу complaintID про виправлення умов закупівлі для
    ...                                                         тендера tender_uaid у статус cancelled, використовуючи при цьому
    ...                                                         дані cancellation_data.

    Скасувати вимогу                                            ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}  null

Скасувати вимогу про виправлення умов лоту
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}
    [Documentation]                                             Перевести вимогу complaintID про виправлення умов лоту для тендера
    ...                                                         tender_uaid у статус cancelled, використовуючи при цьому
    ...                                                         дані cancellation_data.

    Скасувати вимогу                                            ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}  null

Скасувати вимогу про виправлення визначення переможця
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}  ${award_index}
    [Documentation]                                             Перевести вимогу complaintID про виправлення визначення переможця
    ...                                                         під номером award_index для тендера tender_uaid у статус cancelled, використовуючи
    ...                                                         при цьому дані confirmation_data.

    Скасувати вимогу                                            ${username}  ${tender_uaid}  ${complaintID}  ${cancellation_data}  ${award_index}

Підтвердити вирішення вимоги про виправлення умов закупівлі
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${confirmation_data}
    [Documentation]                                             Перевести вимогу complaintID про виправлення умов закупівлі для
    ...                                                         тендера tender_uaid у статус resolved, використовуючи при цьому дані
    ...                                                         confirmation_data.

    Підтвердити вирішення вимоги                                ${username}  ${tender_uaid}  tender  null  ${complaintID}  ${confirmation_data}  null

Підтвердити вирішення вимоги про виправлення умов лоту
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${confirmation_data}
    [Documentation]                                             Перевести вимогу complaintID про виправлення умов лоту для тендера
    ...                                                         tender_uaid у статус resolved, використовуючи при цьому дані confirmation_data.

    Підтвердити вирішення вимоги                                ${username}  ${tender_uaid}  lot  null  ${complaintID}  ${confirmation_data}  null

Підтвердити вирішення вимоги про виправлення визначення переможця
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${confirmation_data}  ${award_index}
    [Documentation]                                             Перевести вимогу complaintID про виправлення визначення переможця
    ...                                                         під номером award_index для тендера tender_uaid у статус resolved, використовуючи
    ...                                                         при цьому дані confirmation_data.

    Підтвердити вирішення вимоги                                ${username}  ${tender_uaid}  award  null  ${complaintID}  ${confirmation_data}  ${award_index}

Перетворити вимогу про виправлення умов закупівлі в скаргу
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${escalating_data}
    [Documentation]                                             Перевести вимогу complaintID про виправлення умов закупівлі для
    ...                                                         тендера tender_uaid у статус pending, використовуючи при цьому дані
    ...                                                         escalating_data.

    Підтвердити вирішення вимоги                                ${username}  ${tender_uaid}  tender  null  ${complaintID}  ${escalating_data}  null

Перетворити вимогу про виправлення умов лоту в скаргу
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${escalating_data}
    [Documentation]                                             Перевести вимогу complaintID про виправлення умов лоту для тендера
    ...                                                         tender_uaid у статус pending, використовуючи при цьому дані escalating_data.

    Підтвердити вирішення вимоги                                ${username}  ${tender_uaid}  lot  null  ${complaintID}  ${escalating_data}  null

Перетворити вимогу про виправлення визначення переможця в скаргу
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${escalating_data}  ${award_index}
    [Documentation]                                             Перевести вимогу complaintID про виправлення визначення переможця
    ...                                                         під номером award_index для тендера tender_uaid у статус pending, використовуючи при
    ...                                                         цьому дані escalating_data.

    Підтвердити вирішення вимоги                                ${username}  ${tender_uaid}  award  null  ${complaintID}  ${escalating_data}  ${award_index}

Отримати інформацію із скарги
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${field_name}  ${award_index}=${None}
    [Documentation]                                             Отримати значення поля field_name скарги/вимоги complaintID про
    ...                                                         виправлення умов закупівлі/лоту для тендера tender_uaid (скарги/вимоги про
    ...                                                         виправлення визначення переможця під номером award_index, якщо award_index != None).

    ${value} =                                                  get claim information  ${tender_uaid}  ${complaintID}  ${field_name}  ${award_index}=${None}
    [Return]                                                    ${value}

Отримати інформацію із документа до скарги
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${doc_id}  ${field_name}
    [Documentation]                                             Отримати значення поля field_name з документу doc_id до скарги/вимоги
    ...                                                         complaintID для тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}
    ${return_value} =                                           Run Keyword If  'title' == '${field_name}'   Отримати інформацію із документа скарги title  ${complaintID}  ${doc_id}
    [return]                                                    ${return_value}

Отримати документ до скарги
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${doc_id}
    [Documentation]                                             Завантажити файл doc_id до скарги complaintID для тендера tender_uaid
    ...                                                         в директорію ${OUTPUT_DIR} для перевірки вмісту цього файлу.

    open tender page by uaid                                    ${tender_uaid}
    ${return_value} =                                           get document complaint  ${complaintID}  ${doc_id}
    [return]                                                    ${return_value}

Відповісти на вимогу про виправлення умов закупівлі
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
    [Documentation]                                             Відповісти на вимогу complaintID про виправлення умов закупівлі для
    ...                                                         тендера tender_uaid, використовуючи при цьому дані answer_data.

    Відповісти на вимогу                                        ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}  null

Відповісти на вимогу про виправлення умов лоту
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}
    [Documentation]                                             Відповісти на вимогу complaintID про виправлення умов лоту для тендера
    ...                                                         tender_uaid, використовуючи при цьому дані answer_data.

    Відповісти на вимогу                                        ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}  null

Відповісти на вимогу про виправлення визначення переможця
    [Arguments]                                                 ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}  ${award_index}
    [Documentation]                                             Відповісти на вимогу complaintID про виправлення визначення переможця
    ...                                                         під номером award_index для тендера tender_uaid, використовуючи при цьому дані answer_data.

    Відповісти на вимогу                                        ${username}  ${tender_uaid}  ${complaintID}  ${answer_data}  ${award_index}


########################################################################################################################
################################################### END CLAIM KEYWORDS #############################################
########################################################################################################################

########################################################################################################################
################################################### BID KEYWORDS #############################################
########################################################################################################################
Подати цінову пропозицію
    [Arguments]                                                 ${username}  ${tender_uaid}  ${bid}  ${lots_ids}=${None}  ${features_ids}=${None}
    [Documentation]                                             Подати цінову пропозицію bid для тендера tender_uaid
    ...                                                         на лоти lots_ids (якщо lots_ids != None) з неціновими
    ...                                                         показниками features_ids (якщо features_ids != None).

    open tender page by uaid                                    ${tender_uaid}
    fill bid form                                               ${tender_uaid}  ${bid}  ${lots_ids}  ${features_ids}
    submit form and check result                                ${bid_form_submit_btn_locator}  ${bid_form_submit_success_msg}  ${tender_created_checker_element_locator}
    wait until page does not contain element with reloading     ${tender_sync_element_locator}

Змінити цінову пропозицію
    [Arguments]                                                 ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
    [Documentation]                                             Змінити поле fieldname на fieldvalue цінової пропозиції користувача
    ...                                                         username для тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}
    fill bid form edit                                          ${fieldname}  ${fieldvalue}
    capture page screenshot
    submit form and check result                                ${bid_form_submit_btn_locator}  ${bid_form_submit_edit_success_msg}  ${tender_created_checker_element_locator}
    wait until page does not contain element with reloading     ${tender_sync_element_locator}

Скасувати цінову пропозицію
    [Arguments]                                                 ${username}  ${tender_uaid}
    [Documentation]                                             Змінити статус цінової пропозиції для тендера tender_uaid
    ...                                                         користувача username на cancelled.

    open tender page by uaid                                    ${tender_uaid}
    fill bid form remove
    submit form and check result                                ${bid_form_submit_btn_locator}  ${bid_form_submit_edit_success_msg}  ${tender_created_checker_element_locator}
    wait until page does not contain element with reloading     ${tender_sync_element_locator}

Завантажити документ в ставку
    [Arguments]                                                 ${username}  ${path}  ${tender_uaid}  ${doc_type}=documents  ${doc_name}=${None}
    [Documentation]                                             Завантажити документ типу doc_type, який знаходиться за шляхом path,
    ...                                                         до цінової пропозиції користувача username для тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}
    add document to bid                                         ${path}  ${doc_type}  ${doc_name}
    capture page screenshot
    submit form and check result                                ${bid_form_submit_btn_locator}  ${bid_form_submit_edit_success_msg}  ${tender_created_checker_element_locator}
    wait until page does not contain element with reloading     ${tender_sync_element_locator}

Змінити документ в ставці
    [Arguments]                                                 ${username}  ${tender_uaid}  ${path}  ${doc_id}
    [Documentation]                                             Змінити документ з doc_id в описі в пропозиції користувача username для
    ...                                                         тендера tender_uaid на документ, який знаходиться по шляху path.

    open tender page by uaid                                    ${tender_uaid}
    document to bid edit                                        ${path}  ${doc_id}
    capture page screenshot
    submit form and check result                                ${bid_form_submit_btn_locator}  ${bid_form_submit_edit_success_msg}  ${tender_created_checker_element_locator}
    wait until page does not contain element with reloading     ${tender_sync_element_locator}

Змінити документацію в ставці
    [Arguments]                                                 ${username}  ${tender_uaid}  ${doc_data}  ${doc_id}
    [Documentation]                                             Змінити тип документа з doc_id в заголовку в пропозиції користувача
    ...                                                         username для тендера tender_uaid. Дані про новий тип документа знаходяться в doc_data.

    open tender page by uaid                                    ${tender_uaid}
    fill bid form edit document                                 ${doc_data}  ${doc_id}
    capture page screenshot
    submit form and check result                                ${bid_form_submit_btn_locator}  ${bid_form_submit_edit_success_msg}  ${tender_created_checker_element_locator}
    wait until page does not contain element with reloading     ${tender_sync_element_locator}

Отримати інформацію із пропозиції
    [Arguments]                                                 ${username}  ${tender_uaid}  ${field}
    [Documentation]                                             Отримати значення поля field пропозиції користувача
    ...                                                         username для тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}
    ${value} =                                                  get bid information  ${field}
    [Return]                                                    ${value}


########################################################################################################################
################################################### END BID KEYWORDS #############################################
########################################################################################################################
################################################### QUALIFICATION KEYWORDS #############################################
########################################################################################################################
Завантажити документ рішення кваліфікаційної комісії
    [Arguments]                                                 ${username}  ${document}  ${tender_uaid}  ${award_num}
    [Documentation]                                             Завантажити документ, який знаходиться по шляху document до
    ...                                                         постачальника під номером award_num для тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}
#    open tender form qualification                              ${award_num}
#    wait until popup is visible
    copy file qualification                                     ${username}  ${document}  ${award_num}

Підтвердити постачальника
    [Arguments]                                                 ${username}  ${tender_uaid}  ${award_num}
    [Documentation]                                             Перевести постачальника під номером award_num для тендера tender_uaid
    ...                                                         в статус active.

    open tender page by uaid                                    ${tender_uaid}
    open tender form qualification                              ${award_num}
    confirm award qualification                                 ${username}  ${award_num}

Дискваліфікувати постачальника
    [Arguments]                                                 ${username}  ${tender_uaid}  ${award_num}
    [Documentation]                                             Перевести постачальника під номером award_num для тендера tender_uaid
    ...                                                         в статус unsuccessful.

    open tender page by uaid                                    ${tender_uaid}
    open tender form qualification                              ${award_num}
    reject award qualification                                  ${username}  ${award_num}

Скасування рішення кваліфікаційної комісії
    [Arguments]                                                 ${username}  ${tender_uaid}  ${award_num}
    [Documentation]                                             Перевести постачальника під номером award_num для тендера tender_uaid
    ...                                                         в статус cancelled.

    open tender page by uaid                                    ${tender_uaid}
    open tender form qualification                              ${award_num}
#    wait until popup is visible
    cancel award qualification

Затвердити постачальників
    [Arguments]                                                 ${username}  ${tender_uaid}
    [Documentation]                                             Перевести постачальників для тендера tender_uaid
    ...                                                         в статус active.

    open tender page by uaid                                    ${tender_uaid}
    confirm awards

########################################################################################################################
################################################### END QUALIFICATION KEYWORDS ########################################
########################################################################################################################

########################################################################################################################
################################################### LIMITED PROCUREMENT KEYWORDS ######################################
########################################################################################################################
Створити постачальника, додати документацію і підтвердити його
    [Arguments]                                                 ${username}  ${tender_uaid}  ${supplier_data}  ${document}
    [Documentation]                                             Додати постачальника supplier_data для тендера tender_uaid, додати до
    ...                                                         нього документ, який знаходиться по шляху document та перевести в статус active.

    open tender form by uaid                                    ${tender_uaid}
    fill tender from award reporting                            ${supplier_data.data.value.amount}  ${supplier_data.data.suppliers[0]}
    run keyword and ignore error                                save tender form and wait synchronization
    confirm award                                               ${document}
########################################################################################################################
################################################### END LIMITED PROCUREMENT KEYWORDS ##################################
########################################################################################################################

########################################################################################################################
################################################### OPEN PROCUREMENT KEYWORDS ####################################
########################################################################################################################
Підтвердити кваліфікацію
    [Arguments]                                                 ${username}  ${tender_uaid}  ${qualification_num}
    [Documentation]                                             Перевести кваліфікацію під номером qualification_num до тендера
    ...                                                         tender_uaid в статус active.

    open tender page by uaid                                    ${tender_uaid}
    open tender form prequalification                           ${qualification_num}
#    wait until popup is visible
    confirm qualifications
#    submit current visible popup

Відхилити кваліфікацію
    [Arguments]                                                 ${username}  ${tender_uaid}  ${qualification_num}
    [Documentation]                                             Перевести кваліфікацію під номером qualification_num до тендера
    ...                                                         tender_uaid в статус unsuccessful.

    open tender page by uaid                                    ${tender_uaid}
    open tender form prequalification                           ${qualification_num}
#    wait until popup is visible
    reject qualifications
#    submit current visible popup


Завантажити документ у кваліфікацію
    [Arguments]                                                 ${username}  ${document}  ${tender_uaid}  ${qualification_num}
    [Documentation]                                             Завантажити документ, який знаходиться по шляху document, до
    ...                                                         кваліфікації під номером qualification_num до тендера tender_uaid.

    open tender page by uaid                                    ${tender_uaid}

Скасувати кваліфікацію
    [Arguments]                                                 ${username}  ${tender_uaid}  ${qualification_num}
    [Documentation]                                             Перевести кваліфікацію під номером qualification_num до тендера
    ...                                                         tender_uaid в статус cancelled.

    open tender page by uaid                                    ${tender_uaid}
    open tender form prequalification                           ${qualification_num}
#    wait until popup is visible
    cancel qualifications

Затвердити остаточне рішення кваліфікації
    [Arguments]                                                 ${username}  ${tender_uaid}
    [Documentation]                                             Перевести тендер tender_uaid в статус active.pre-qualification.stand-still.

    open tender page by uaid                                    ${tender_uaid}
    wait until page contains element with reloading             ${prequalification_form_approve_open_btn_locator}
    click visible element                                       ${prequalification_form_approve_open_btn_locator}
    approve the final qualification decision

Перевести тендер на статус очікування обробки мостом
    [Arguments]                                                 ${username}  ${tender_uaid}
    [Documentation]                                             Перевести тендер tender_uaid в статус active.stage2.waiting.

    open tender page by uaid                                    ${tender_uaid}
    confirm-stage2

Отримати доступ до тендера другого етапу
    [Arguments]                                                 ${username}  ${tender_uaid}
    [Documentation]                                             Отримати тендер другого етапу по tender id, зберегти його.

    open tender page by uaid                                    ${tender_uaid}
    Log to Console  ${tender_uaid}

Активувати другий етап
    [Arguments]                                                 ${username}  ${tender_uaid}
    [Documentation]                                             Перевести тендер tender_uaid в статус active.tendering.

    open tender form by uaid                                    ${tender_uaid}
    activate stage 2
    submit form and check result                                ${tender_form_submit_btn_locator}  ${tender_form_submit_success_msg}  ${tender_created_checker_element_locator}
    sleep  15m


Отримати тендер другого етапу та зберегти його
    [Arguments]                                                 ${username}  ${tender_uaid}
    [Documentation]                                             Отримати тендер другого етапу по tender id, зберегти його.

    open tender page by uaid                                    ${tender_uaid}
    Log to Console  ${tender_uaid}

########################################################################################################################
################################################### END OPEN PROCUREMENT KEYWORDS ###############################
########################################################################################################################

########################################################################################################################
################################################### DOCUMENT KEYWORDS ####################################
########################################################################################################################
Отримати інформацію із документа
    [Arguments]                                                 ${username}  ${tender_uaid}  ${doc_id}  ${field}
    [Documentation]                                             Отримати значення поля field документа doc_id з тендера
    ...                                                         tender_uaid для перевірки правильності відображення цього поля.

    open tender page by uaid                                    ${tender_uaid}
    ${return_value} =                                           Run Keyword If  'title' == '${field}'   Отримати інформацію із документа title  ${doc_id}
    [return]                                                    ${return_value}

Отримати документ
    [Arguments]                                                 ${username}  ${tender_uaid}  ${doc_id}
    [Documentation]                                             Завантажити файл з doc_id в заголовку для тендера tender_uaid в
    ...                                                         директорію OUTPUT_DIR для перевірки вмісту цього файлу.

    open tender page by uaid                                    ${tender_uaid}
    ${tender_new_doc_locator} =                                 replace string  ${tender_new_doc_locator_tpl}  %doc_id%  ${doc_id}
    wait until page contains element with reloading             ${tender_new_doc_locator}

    ${file_link} =                                              Execute Javascript  return $('.docs__list .docs__item.js-item:first a.doc__link[href*="https://public-docs-sandbox.prozorro.gov.ua"]').val('.docs__list .docs__item.js-item:first a.doc__link[href*="https://public-docs-sandbox.prozorro.gov.ua"]').attr("href")
    ${file_name} =                                              get text  ${tender_new_doc_locator}
    download_file  ${file_link}  ${file_name}  ${OUTPUT_DIR}
    [return]                                                    ${file_name}


Отримати документ до лоту
    [Arguments]                                                 ${username}  ${tender_uaid}  ${lot_id}  ${doc_id}
    [Documentation]                                             Завантажити файл з doc_id в заголовку для тендера tender_uaid для лоту lot_id
    ...                                                         в директорію OUTPUT_DIR для перевірки вмісту цього файлу.

    open tender page by uaid                                    ${tender_uaid}
    ${tender_new_doc_locator} =                                 replace string  ${tender_new_doc_locator_tpl}  %doc_id%  ${doc_id}
    wait until page contains element with reloading             ${tender_new_doc_locator}
    ${file_link} =                                              Execute Javascript  return $('.docs__list .docs__item.js-item:last a.doc__link[href*="https://public-docs-sandbox.prozorro.gov.ua"]').val('.docs__list .docs__item.js-item:first a.doc__link[href*="https://public-docs-sandbox.prozorro.gov.ua"]').attr("href")
    ${file_name} =                                              get text  ${tender_new_doc_locator}
    download_file  ${file_link}  ${file_name}  ${OUTPUT_DIR}
    [return]                                                    ${file_name}

Отримати посилання на аукціон для глядача
    [Arguments]                                                 ${username}  ${tender_uaid}  ${lot_id}=Empty
    [Documentation]                                             Отримати посилання на аукціон для тендера tender_uaid (або для лоту з
    ...                                                         lot_id в описі для тендера tender_uaid, якщо lot_id != Empty).

    open tender page by uaid                                    ${tender_uaid}
    log many  ${mode}
    run keyword if                                              "${mode}" not in "belowThreshold"  wait until page contains element with reloading             ${tender_auction_locator}  10
    run keyword if                                              "${mode}" in "belowThreshold"  wait until page contains element with reloading             ${tender_auction_belowThreshold_input_locator}
    ${return_value} =                                           run keyword if  "${mode}" not in "belowThreshold below_funders"  Execute Javascript  return $('#auction-info a[href*="https://auction-sandbox"]').attr("href")
#    ${return_value} =                                           run keyword if  "${mode}" in "belowThreshold"  Execute Javascript  return $('#aside-part-pjax a[href*="https://auction-sandbox"]').attr("href")
    ...                                                         ELSE IF  '${mode}' in 'belowThreshold below_funders'  Execute Javascript  return $('#aside-part-pjax a[href*="https://auction-sandbox"]').attr("href")
    [return]                                                    ${return_value}

Отримати посилання на аукціон для учасника
    [Arguments]                                                 ${username}  ${tender_uaid}  ${lot_id}=Empty
    [Documentation]                                             Отримати посилання на участь в аукціоні для користувача username для тендера
    ...                                                         tender_uaid (або для лоту з lot_id в описі для тендера tender_uaid, якщо lot_id != Empty).

    open tender page by uaid                                    ${tender_uaid}
    log many  ${mode}
    run keyword if                                              "${mode}" not in "belowThreshold"  wait until page contains element with reloading             ${tender_auction_locator}  10
    run keyword if                                              "${mode}" in "belowThreshold"  wait until page contains element with reloading             ${tender_auction_belowThreshold_input_locator}
    ${return_value} =                                           run keyword if  "${mode}" not in "belowThreshold"  Execute Javascript  return $('#auction-info a[href*="https://auction-sandbox"]').attr("href")
#    ${return_value} =                                           run keyword if  "${mode}" in "belowThreshold"  Execute Javascript  return $('#aside-part-pjax a[href*="https://auction-sandbox"]').attr("href")
    ...                                                         ELSE IF  '${mode}' in 'belowThreshold'  Execute Javascript  return $('#aside-part-pjax a[href*="https://auction-sandbox"]').attr("href")
    [return]                                                    ${return_value}
########################################################################################################################
################################################### END DOCUMENT KEYWORDS ###############################
########################################################################################################################

########################################################################################################################
################################################### FUNDERS KEYWORDS ###############################
########################################################################################################################

Видалити донора
    [Arguments]                                                 ${username}  ${tender_uaid}  ${funders_index}
    [Documentation]                                             Видалити донора для користувача username для тендера tender_uaid з індексом funders_index

    open tender form by uaid                                    ${tender_uaid}
    open popup by btn locator                                   ${plan_form_general_panel_edit_btn_locator}
    click visible element                                       ${tender_form_general_tender_funder_locator}
    submit current visible popup
    save tender form and wait synchronization

Додати донора
    [Arguments]                                                 ${username}  ${tender_uaid}  ${funders_data}
    [Documentation]                                             Додати донора для користувача username для тендера tender_uaid з даними funders_data

    open tender form by uaid                                    ${tender_uaid}
    open popup by btn locator                                   ${plan_form_general_panel_edit_btn_locator}
    click visible element                                       ${tender_form_general_tender_funder_locator}
    ${funders} =                                                create list  ${funders_data}
    fill tender form funders                                    ${funders}
    submit current visible popup
    save tender form and wait synchronization

########################################################################################################################
################################################### END FUNDERS KEYWORDS ####################################
########################################################################################################################
########################################################################################################################
################################################### CONTRACTS KEYWORDS ###############################
########################################################################################################################

Редагувати угоду
    [Arguments]                                                 ${username}  ${tender_uaid}  ${contract_index}  ${field_name}  ${amount}
    [Documentation]                                             Редагувати контракт для користувача username для тендера tender_uaid з індексом contract_index
    ...                                                         для поля field_name та значення amount.

    open tender page by uaid                                    ${tender_uaid}
    edit contract                                               ${contract_index}  ${field_name}  ${amount}
    wait until page does not contain element with reloading     ${tender_sync_element_locator}

Встановити дату підписання угоди
    [Arguments]                                                 ${username}  ${tender_uaid}  ${contract_index}  ${dateSigned}
    [Documentation]                                             Редагувати контракт для користувача username для тендера tender_uaid з індексом contract_index
    ...                                                         для поля Дата підписання задати значення dateSigned.

    open tender page by uaid                                    ${tender_uaid}
#    edit contract                                               ${contract_index}  ${dateSigned}  ${dateSigned}
    click visible element                                       ${contract_form_0_open_btn_locator}
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  5
    wait until element is visible                               ${contract_contractform_contract_number_input_locator}  60
    input datetime to exist visible input                       ${contract_contractform_date_signed_input_locator}  ${dateSigned}

    run keyword and ignore error                                submit form and check result  ${contract_contractform_submit_btn_locator}  ${contract_contractform_submit_success_msg}  ${contract_active_form_open_btn_locator}
    capture page screenshot

    wait until page does not contain element with reloading     ${tender_sync_element_locator}

Вказати період дії угоди
    [Arguments]                                                 ${username}  ${tender_uaid}  ${contract_index}  ${startDate}  ${endDate}
    [Documentation]                                             Редагувати контракт для користувача username для тендера tender_uaid з індексом contract_index
    ...                                                         для поля Дата початку дії контракту задати значення startDate, для дати завершення - endDate.

    open tender page by uaid                                    ${tender_uaid}
#    edit contract                                               ${contract_index}  ${dateSigned}  ${dateSigned}
    click visible element                                       ${contract_form_0_open_btn_locator}
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  5
    wait until element is visible                               ${contract_contractform_contract_number_input_locator}  60
    input datetime to exist visible input                       ${contract_contractform_date_start_input_locator}  ${startDate}
    input datetime to exist visible input                       ${contract_contractform_date_end_input_locator}  ${endDate}

    run keyword and ignore error                                submit form and check result  ${contract_contractform_submit_btn_locator}  ${contract_contractform_submit_success_msg}  ${contract_active_form_open_btn_locator}
    capture page screenshot

    wait until page does not contain element with reloading     ${tender_sync_element_locator}

Завантажити документ в угоду
    [Arguments]                                                 ${username}  ${document}  ${tender_uaid}  ${contract_index}
    [Documentation]                                             Редагувати контракт для користувача username для тендера tender_uaid з індексом contract_index
    ...                                                         для додавання документу використовувати значення document.

    open tender page by uaid                                    ${tender_uaid}
#    edit contract                                               ${contract_index}  ${dateSigned}  ${dateSigned}
    click visible element                                       ${contract_form_0_open_btn_locator}
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  5
    wait until element is visible                               ${contract_contractform_contract_number_input_locator}  60
    choose file                                                 ${add_file_to_contract_contractform_locator}  ${document}
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

    run keyword and ignore error                                submit form and check result  ${contract_contractform_submit_btn_locator}  ${contract_contractform_submit_success_msg}  ${contract_active_form_open_btn_locator}
    capture page screenshot

    wait until page does not contain element with reloading     ${tender_sync_element_locator}

Підтвердити підписання контракту
    [Arguments]                                                 ${username}  ${tender_uaid}  ${contract_index}
    [Documentation]                                             Редагувати контракт для користувача username для тендера tender_uaid з індексом contract_index
    ...                                                         для поля Дата підписання задати значення dateSigned.

    open tender page by uaid                                    ${tender_uaid}
#    edit contract                                               ${contract_index}  ${dateSigned}  ${dateSigned}
    click visible element                                       ${contract_active_form_open_btn_locator}
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  5
    wait until element is visible                               ${contract_contractform_submit_btn_locator}  60

    Execute Javascript  $('.fancybox-is-open .fancybox-content button.btn.btn-success').click()
    Run Keyword And Ignore Error                                wait until element is visible                               ${qualification_ecp_form_open_locator}  60
    run keyword and ignore error                                wait until element is visible  ${tender_status_active_qualification_value_locator}  10
    capture page screenshot
    run keyword and ignore error                                Load Sign
    capture page screenshot

    run keyword and ignore error                                submit form and check result  ${contract_contractform_submit_btn_locator}  ${contract_contractform_active_submit_success_msg}  ${contract_active_form_open_btn_locator}
    capture page screenshot

    wait until page does not contain element with reloading     ${tender_sync_element_locator}

Встановити ціну за одиницю для контракту
    [Arguments]                                                 ${username}  ${tender_uaid}  ${contract_data}
    [Documentation]                                             Встановити ціну за одиницю для контракту для користувача username для тендера tender_uaid,
    ...                                                         використовуючи значення з contract_data.

    open tender page by uaid                                    ${tender_uaid}
    edit unitprices                                             ${tender_uaid}  ${contract_data}

Зареєструвати угоду
    [Arguments]                                                 ${username}  ${tender_uaid}  ${startDate}  ${endDate}
    [Documentation]                                             Зареєструвати угоду для користувача username для тендера tender_uaid,
    ...                                                         для поля Дата початку дії угоди задати значення startDate, для дати завершення - endDate.

    open tender page by uaid                                    ${tender_uaid}
    active agreement contract                                   ${startDate}  ${endDate}

########################################################################################################################
################################################### END CONTRACTS KEYWORDS ####################################
########################################################################################################################
