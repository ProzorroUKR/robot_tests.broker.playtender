*** Settings ***

Resource                                                        playtender_common.robot
Resource                                                        playtender_agreement_variables.robot
Resource                                                        playtender_question.robot
Resource                                                        playtender_claim.robot
Resource                                                        playtender_bid.robot
Resource                                                        playtender_viewer.robot

*** Keywords ***

update agreement queue
    [Documentation]                                             запускає оновлення agreement з ЦБД і додає їх в чергу, тобто синхронізація може відбутися не відразу
    ...                                                         поточна сторіка повертається

    ${current_url} =                                            get location
    go to                                                       ${broker_baseurl}/utils/queue-agreement-update
    go to                                                       ${current_url}

open agreement search form
    [Documentation]                                             відкриває сторінку з пошуком agreement

    open page and wait element by locator                       ${broker_baseurl}/agreements  ${agreement_search_form_locator}

open agreement form by uaid
    [Arguments]                                                 ${agreement_uaid}
    [Documentation]                                             відкриття сторінки редагування плану

    open agreement page by uaid                                 ${agreement_uaid}
    click visible element and wait until page contains element  ${tender_edit_btn_locator}  ${tender_form_locator}

open agreement page by uaid
    [Arguments]                                                 ${uaid}
    [Documentation]                                             відкриває сторінку з agreement

    open site page and wait content element                     ${broker_baseurl}/agreement/${uaid}
    ${is_agreement_found} =                                     get is element exist  ${agreement_view_checker_element_locator}
    return from keyword if                                      ${is_agreement_found} == ${True}
    ${is_agreement_not_found} =                                 get is 404 page
    ${is_needed_to_update_and_wait_sync} =                      set variable if  ${is_test_role_owner} == ${False} and ${is_agreement_not_found}  ${True}  ${False}
    run keyword if                                              ${is_needed_to_update_and_wait_sync}  update agreement queue
    run keyword if                                              ${is_needed_to_update_and_wait_sync}  wait until 404 page disappears
    ${is_agreement_found} =                                     get is element exist  ${agreement_view_checker_element_locator}
    run keyword if                                              ${is_agreement_found} == ${False}  fail  Opening agreement page by uaid fails.

save agreement form and wait synchronization
    [Documentation]                                             натискає кнопку "Зберегти" і чекає синхронізації угоди

    submit form and check result                                ${tender_form_submit_btn_locator}  ${tender_form_submit_success_msg}  ${tender_created_checker_element_locator}  ${true}
    wait until page does not contain element with reloading     ${agreement_sync_element_locator}

add document in agreement
    [Arguments]                                                 ${filepath}
    [Documentation]                                             Завантажити документ, який знаходиться по шляху filepath.

    click visible element                                       ${tender_form_general_panel_edit_add_document_btn_locator}
    choose file                                                 ${add_file_to_form_locator}  ${filepath}
    wait until page does not contain element                    ${popup_dynamic_form_loading_element_locator}
    submit current visible popup


