*** Variables ***

# plan form
${plan_form_submit_success_msg} =                                   дочекайтесь опублікування на сайті уповноваженого органу
${plan_form_locator} =                                              id=plan-form
${plan_form_general_panel_edit_btn_locator} =                       jquery=#General .panel-heading .js-form-popup-update
${plan_form_procurement_method_type_input_locator} =                id=planform-procurement_method_type
${plan_form_budget_id_input_locator} =                              id=planform-budget_id
${plan_form_project_id_input_locator} =                             id=planform-project_id
${plan_form_project_name_input_locator} =                           id=planform-project_name
${plan_form_title_input_locator} =                                  id=planform-title
${plan_form_year_input_locator} =                                   id=planform-year
${plan_form_tender_start_date_input_locator} =                      id=planform-tender_start_date
${plan_form_value_amount_input_locator} =                           id=planform-value_amount
${plan_form_value_currency_input_locator} =                         id=planform-value_currency
${plan_form_classification_edit_btn_locator} =                      jquery=.field-planform-classification_id .js-classification-input-wrapper [data-toggle="classification"]
${plan_form_additional_classification_edit_btn_locator} =           jquery=.field-planform-additional_classification_ids .js-additional-classification-input-wrapper [data-toggle="additional-classification"]
${plan_form_kekv_classification_edit_btn_locator} =                 jquery=.field-planform-additional_classification_ids_kekv .js-additional-classification-input-wrapper [data-toggle="additional_classification_ids_kekv"]
${plan_form_add_item_btn_locator} =                                 jquery=#Items .js-form-popup-add
${plan_form_update_item_btn_locator_tpl} =                          jquery=#Items .js-form-popup-panel:nth(%index%) .panel-heading .js-form-popup-update
${plan_form_remove_item_btn_locator_tpl} =                          jquery=#Items .js-form-popup-panel[data-title*="%title%"] .panel-heading .js-form-popup-remove
${plan_form_update_buyer_btn_locator} =                             jquery=#Buyer .js-form-popup-update
${plan_form_submit_btn_locator} =                                   jquery=#plan-form .js-submit-btn
${plan_created_checker_element_locator} =                           id=plan-part-pjax
${plan_form_update_budgetbreakdowns_btn_locator} =                  jquery=#BudgetBreakdowns .js-form-popup-update
${plan_form_add_budgetbreakdowns_btn_locator} =                     jquery=#budgetbreakdowns-form-popup a[href*="#add-budgetBreakdowns"]
${plan_budgetbreakdowns_form_popup_title_input_locator} =           jquery=.fancybox-is-open:last .tab-content:first > .tab-pane.active:first [id$="-title"]
${plan_budgetbreakdowns_value_amount_input_locator} =               jquery=.fancybox-is-open:last .tab-content:first > .tab-pane.active:first [id$="-value_amount"]
${plan_budgetbreakdowns_description_input_locator} =                jquery=.fancybox-is-open:last .tab-content:first > .tab-pane.active:first [id$="-description"]

# plan view
${plan_view_checker_element_locator} =                              id=plan-general-info
${plan_sync_element_locator} =                                      jquery=#aside-part-pjax .status-label .fa-refresh
${plan_uaid_text_locator} =                                         jquery=#plan-general-info .plan-id .value
${plan_edit_btn_locator} =                                          jquery=#aside-part-pjax a[href*='plan/update']
# -- for viewer --
${plan_tender_procurementMethodType_value_locator} =                jquery=#plan-general-info .procurement-method-type.hidden
${plan_budget_amount_value_locator} =                               jquery=#plan-general-info .budget-amount.hidden
${plan_budget_amount_value_type} =                                  float
${plan_budget_description_value_locator} =                          jquery=#plan-general-info .budget-description .value
${plan_budget_currency_value_locator} =                             jquery=#plan-general-info .budget-currency.hidden
${plan_budget_id_value_locator} =                                   jquery=#plan-general-info .budget-id .value
${plan_procuringEntity_name_value_locator} =                        jquery=#plan-general-info .organization .definitions__list .organization_name.hidden .definitions__value
${plan_procuringEntity_identifier_scheme_value_locator} =           jquery=#plan-general-info .organization .definitions__list .identifier_scheme.hidden .definitions__value
${plan_procuringEntity_identifier_id_value_locator} =               jquery=#plan-general-info .organization .definitions__list .identifier_code .definitions__value
${plan_procuringEntity_identifier_legalName_value_locator} =        jquery=#plan-general-info .organization .definitions__list .identifier_legal_name.hidden .definitions__value
${plan_classification_description_value_locator} =                  jquery=#plan-general-info .main-classification-description.hidden
${plan_classification_scheme_value_locator} =                       jquery=#plan-general-info .main-classification-scheme.hidden
${plan_classification_id_value_locator} =                           jquery=#plan-general-info .main-classification-code.hidden
${plan_tender_tenderPeriod_startDate_value_locator} =               jquery=#plan-general-info .tender-start-date-source.hidden
${plan_items_0_description_value_locator} =                         jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(1) .textvalue
${plan_items_0_quantity_value_locator} =                            jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(1) .item-info-wrapper .quantity-source
${plan_items_0_quantity_value_type} =                               float
${plan_items_0_deliveryDate_endDate_value_locator} =                jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(1) .item-info-wrapper .delivery-end-date-source
${plan_items_0_unit_code_value_locator} =                           jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(1) .item-info-wrapper .unit-code-source
${plan_items_0_unit_name_value_locator} =                           jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(1) .item-info-wrapper .unit-title-source
${plan_items_0_classification_description_value_locator} =          jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(1) .item-info-wrapper .main-classification-description
${plan_items_0_classification_scheme_value_locator} =               jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(1) .item-info-wrapper .main-classification-scheme
${plan_items_0_classification_id_value_locator} =                   jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(1) .item-info-wrapper .main-classification-code
${plan_items_1_description_value_locator} =                         jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(2) .textvalue
${plan_items_1_quantity_value_locator} =                            jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(2) .item-info-wrapper .quantity-source
${plan_items_1_quantity_value_type} =                               float
${plan_items_1_deliveryDate_endDate_value_locator} =                jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(2) .item-info-wrapper .delivery-end-date-source
${plan_items_1_unit_code_value_locator} =                           jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(2) .item-info-wrapper .unit-code-source
${plan_items_1_unit_name_value_locator} =                           jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(2) .item-info-wrapper .unit-title-source
${plan_items_1_classification_description_value_locator} =          jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(2) .item-info-wrapper .main-classification-description
${plan_items_1_classification_scheme_value_locator} =               jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(2) .item-info-wrapper .main-classification-scheme
${plan_items_1_classification_id_value_locator} =                   jquery=.items-wrapper .pseudo-table .pseudo-table__row:nth(2) .item-info-wrapper .main-classification-code
${plan_status_value_locator} =                                      jquery=#aside-part-pjax .opstatus.hidden

# plan index + search
${plan_search_form_locator} =                                       id=plan-filter-form
${plan_search_form_query_input_locator} =                           jquery=#plan-filter-form .dynamic-search-query input
${plan_search_form_result_locator_tpl} =                            jquery=#plan-list .lots__item .lot__characteristic li:contains(%query%)