*** Variables ***

${kekv_schemes} =                                                   ["KEKV", "КЕКВ"]
${site_allowed_schemes} =                                           ["ДК021", "ДК015", "ДК018", "ДК003", "specialNorms", "INN", "ATC"]
${page_content_locator} =                                           jquery=.page__content

# alerts
${alert_opened_locator} =                                           jquery=.jconfirm:last .content
${alert_confirm_btn_locator} =                                      jquery=.jconfirm:last .buttons .js-btn-confirm
${alert_opened_close_btn_locator} =                                 jquery=.jconfirm:last .closeIcon
${alert_message_contains_text_locator_tpl} =                        jquery=.jconfirm:last .message:contains(%text%)

# popups
${popup_opened_last_locator} =                                      jquery=.fancybox-is-open:last
${popup_opened_last_submit_btn_locator} =                           jquery=.fancybox-is-open:last .fancybox-slide--current .modal-footer:last .js-submit,.fancybox-is-open:last .fancybox-slide--current .modal-footer:last .js-popup-submit
${popup_opened_content_locator} =                                   jquery=.fancybox-is-open .fancybox-slide--current .fancybox-content  # for checking if it's visible

# error pages
${error_page_404_checker_element_locator} =                         jquery=.site-error[data-error-code="404"]

# language
${language_selector_active_element_locator} =                       jquery=.languages.page-header__languages .languages__btn
${language_selector_active_element_code_attribute_name} =           data-language-code
${language_selector_open_element_locator} =                         jquery=.languages.page-header__languages .js-popup-open-initiator
${language_selector_active_element_by_code_locator_tpl} =           jquery=.languages.page-header__languages .languages__btn[data-language-code='%code%']
${language_selector_list_element_locator_tpl} =                     jquery=.languages.page-header__languages .popup.languages__menu .languages__link[data-language-code='%code%']

# classification popup
${classification_popup_opened_content_locator} =                    jquery=.fancybox-is-open .fancybox-slide--current .fancybox-content.classification-modal  # for checking if it's visible
${classification_popup_scheme_tab_locator_tpl} =                    jquery=.fancybox-is-open .fancybox-slide--current .fancybox-content.classification-modal .nav a[data-toggle="tab"][data-scheme="%scheme%"]
${classification_popup_search_input_locator} =                      jquery=.fancybox-is-open .fancybox-slide--current .fancybox-content.classification-modal .js-search-wrapper:visible .js-input
${classification_popup_serach_item_locator_tpl} =                   jquery=.fancybox-is-open .fancybox-slide--current .fancybox-content.classification-modal .js-search-wrapper:visible .js-search-tree strong:contains(%code%)

# authorization
${login_popup_open_locator} =                                       jquery=.page__header a[data-action="login"]
${login_popup_login_input_locator} =                                id=loginform-identity
#${login_popup_login_input_locator} =                                id=loginform-email
${login_popup_password_input_locator} =                             id=loginform-password
${login_popup_submit_btn_locator} =                                 jquery=#login-form .js-submit-btn
${user_logged_checker_element_locator} =                            id=notifications-button  # елемент для перевірки чи авторизований користувач

# item form
${item_form_popup_description_input_locator} =                      jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-description']
${item_form_popup_description_ru_input_locator} =                   jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-description_ru']
${item_form_popup_description_en_input_locator} =                   jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-description_en']
${item_form_popup_quantity_input_locator} =                         jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-quantity']
${item_form_popup_unit_input_locator} =                             jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-unit_id']
${item_form_popup_classification_edit_btn_locator} =                jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content .js-classification-input-wrapper [data-toggle="classification"]
${item_form_popup_additional_classification_edit_btn_locator} =     jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content .js-additional-classification-input-wrapper [data-toggle="additional-classification"]
${item_form_popup_delivery_region_id_input_locator} =               jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-delivery_region_id']
${item_form_popup_delivery_postal_code_input_locator} =             jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-delivery_postal_code']
${item_form_popup_delivery_locality_input_locator} =                jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-delivery_locality']
${item_form_popup_delivery_street_address_input_locator} =          jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-delivery_street_address']
${item_form_popup_delivery_start_date_input_locator} =              jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-delivery_start_date']
${item_form_popup_delivery_end_date_input_locator} =                jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-delivery_end_date']

# buyer form
${buyer_form_popup_legal_name_input_locator} =                      jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-procuring_entity_name']
${buyer_form_popup_identifier_id_input_locator} =                   jquery=.fancybox-is-open:last .fancybox-slide--current .fancybox-content [id$='-procuring_entity_identifier_code']

# tender form
${tender_load_form_after_mode_locator} =                            jquery=#tender-form-pjax.loading-wrapper
#${tender_form_submit_success_msg} =                                 дочекайтеся опублікування на сайті уповноваженого органу
${tender_form_submit_success_msg} =                                 опублікування на сайті уповноваженого органу
${tender_form_submit_reporting_success_msg} =                       Закупівля успішно створена, дочекайтесь закінчення синхронізації, після чого потрібно накласти ЕЦП/КЕП
${tender_form_locator} =                                            id=tender-form
${tender_form_procurement_method_type_input_locator} =              jquery=.form-inline [id$="form-procurement_method_type"]
${tender_multilot_locator} =                                        jquery=[id$="form-is_multilot"]
${tender_form_general_panel_edit_btn_locator} =                     jquery=#General #headingGeneral .actions-wrapper .js-form-popup-update
${tender_form_general_tender_plan_id_locator} =                     jquery=[id$="form-plan_id"]
${tender_form_general_tender_title_locator} =                       jquery=[id$="form-title"]
${tender_form_general_tender_title_en_locator} =                    jquery=[id$="form-title_en"]
${tender_form_general_tender_description_locator} =                 jquery=[id$="form-description"]
${tender_form_general_tender_description_en_locator} =              jquery=[id$="form-description_en"]
${tender_form_general_tender_funder_locator} =                      jquery=[id$="form-is_donor"]
${tender_form_general_tender_funder_name_locator} =                 jquery=[id$="-funder_organization_id"]
${tender_form_general_value_amount_input_locator} =                 jquery=[id$="form-value_amount-disp"]
${tender_form_general_value_currency_input_locator} =               jquery=[id$="form-value_currency"]
${tender_form_general_value_added_tax_input_locator} =              jquery=[id$="form-value_added_tax_included"]
#${tender_form_general_minimalStep_amount_input_locator} =           jquery=[id$="form-min_step_amount"]
${tender_form_general_minimalStep_amount_input_locator} =           jquery=[id$="form-min_step_amount-disp"]
${tender_form_general_main_procurement_category_input_locator} =    jquery=[id$="form-main_procurement_category"]
${tender_enquiry_period_start_date_input_locator} =                 jquery=[id$="form-enquiry_period_start_date"]
${tender_enquiry_period_end_date_input_locator} =                   jquery=[id$="form-enquiry_period_end_date"]
${tender_tender_period_start_date_input_locator} =                  jquery=[id$="form-tender_period_start_date"]
${tender_tender_period_end_date_input_locator} =                    jquery=[id$="form-tender_period_end_date"]
${tender_tender_quick_mode_locator} =                               jquery=[id$="form-quick_mode"]
${tender_cpv_form_submit_success_msg} =                             Вид предмету закупівлі не відповідає вказаному коду CPV
${tender_cpv_submit_btn_locator} =                                  jquery=.animated-content .js-btn-confirm
${tender_cpv_js_submit_btn_locator} =                               $('.animated-content .js-btn-confirm').click()

#esco
${tender_form_general_funding_kind_input_locator} =                 id=tenderescoform-funding_kind
${tender_form_general_nbu_discount_rate_input_locator} =            id=tenderescoform-nbu_discount_rate
${tender_form_general_minimal_step_percentage_input_locator} =      jquery=[id$="-min_step_percentage"]
${tender_form_general_yearly_payments_percentage_range_input_locator} =  jquery=[id$="-yearly_payments_percentage_range"]
#closeframework
${tender_form_general_max_awards_count_input_locator} =             jquery=[id$="form-max_awards_count"]
${tender_form_general_agreement_duration_years_input_locator} =     jquery=[id$="form-agreement_duration_years"]
${tender_form_general_agreement_duration_months_input_locator} =    jquery=[id$="form-agreement_duration_months"]
${tender_form_general_agreement_duration_days_input_locator} =      jquery=[id$="form-agreement_duration_days"]
#closeFrameworkAgreementSelectionUA
${tender_form_general_agreementid_input_locator} =                  jquery=[id$="form-agreement_id"]
${tender_form_item_edit_btn_locator} =                              jquery=.form-group-popup-panel[data-attribute="items"]:last > .panel-collapse.collapse.in .panel-heading .js-form-popup-update:first
#${tender_form_general_max_awards_count_input_locator} =             jquery=[id$="form-max_awards_count"]
#${tender_form_general_agreement_duration_years_input_locator} =     jquery=[id$="form-agreement_duration_years"]
#${tender_form_general_agreement_duration_months_input_locator} =    jquery=[id$="form-agreement_duration_months"]
#${tender_form_general_agreement_duration_days_input_locator} =      jquery=[id$="form-agreement_duration_days"]
#negotiation
${tender_form_general_cause_input_locator} =                        jquery=[id$="form-cause"]
${tender_form_general_cause_description_input_locator} =            jquery=[id$="form-cause_description"]
${tender_form_cp_edit_btn_locator} =                                jquery=[id="headingContactPoint"] a[data-url="#contactpoint-form-popup"]
${tender_form_organization_name_en_input_locator} =                 jquery=[id*="organization_name_en"]
${tender_form_contact_point_name_en_input_locator} =                jquery=[id*="contact_point_name_en"]

#Tests Files.Complaints
${tender_form_auction_skip_mode_input_locator} =                    jquery=input[id$="form-auction_skip_mode"]

${tender_form_general_panel_add_feature_btn_locator} =              jquery=#collapseGeneral .btn[data-attribute="features"]
${tender_form_features_panel_edit_btn_locator} =                    $('.fancybox-content [href$="#add-features"]').trigger("click")
#${tender_form_features_panel_edit_btn_locator} =                    jquery=.fancybox-content [href$="#add-features"]
${feature_form_popup_title_input_locator} =                         jquery=.fancybox-is-open .tab-content:first > .tab-pane.active:first [id$="-title"]:first
${feature_form_popup_description_input_locator} =                   jquery=.fancybox-is-open .tab-content:first > .tab-pane.active:first [id$="-description"]:first
${feature_form_popup_title_en_input_locator} =                      jquery=.fancybox-is-open .tab-content:first > .tab-pane.active:first [id$="-title_en"]:first
${feature_form_popup_description_en_input_locator} =                jquery=.fancybox-is-open .tab-content:first > .tab-pane.active:first [id$="-description_en"]:first
${feature_form_popup_value_input_locator} =                         jquery=[id$="-value"]
${feature_form_popup_add-enums_btn_locator} =                       jquery=.fancybox-is-open .enums-dynamic-forms-wrapper .btn-add a[href$="#add-enums"]:last
${feature_form_popup_enum_title_input_locator} =                    jquery=.fancybox-is-open .enums-dynamic-forms-wrapper .tab-content:last > .tab-pane.active input[id$="-title"]
${feature_form_popup_enum_title_en_input_locator} =                 jquery=.fancybox-is-open .enums-dynamic-forms-wrapper .tab-content:last > .tab-pane.active input[id$="-title_en"]
${feature_form_popup_enum_value_input_locator} =                    jquery=.fancybox-is-open .enums-dynamic-forms-wrapper .tab-content:last > .tab-pane.active input[id$="-value"]
#${feature_form_popup_enum_title_input_locator} =                    jquery=.fancybox-is-open .enums-dynamic-forms-wrapper .tab-content:first > .tab-pane.active input[id$="-title"]
#${feature_form_popup_enum_title_en_input_locator} =                 jquery=.fancybox-is-open .enums-dynamic-forms-wrapper .tab-content:first > .tab-pane.active input[id$="-title_en"]
#${feature_form_popup_enum_value_input_locator} =                    jquery=.fancybox-is-open .enums-dynamic-forms-wrapper .tab-content:first > .tab-pane.active input[id$="-value"]

${tender_form_general_panel_add_document_btn_locator} =             jquery=#collapseGeneral .btn[data-attribute="documents"]
${tender_form_general_panel_edit_add_document_btn_locator} =        jquery=div[data-form="general-form-popup"] .js-form-hidden-popup-panel:last a.btn-update

#${tender_form_item_add_edit_btn_locator} =                          jquery=.js-form-group-popup-panel .panel-heading .actions-wrapper .js-form-popup-add
#последняя кнопка “Додати” для номенклатуры (для лотовой и безлотовой и репортинг)
${tender_form_item_add_edit_btn_locator} =                          jquery=.form-group-popup-panel[data-attribute="items"]:last > .panel-heading .js-form-popup-add
${tender_form_item_panel_add_feature_btn_locator} =                 jquery=.form-group-popup-panel[data-attribute="items"]:last .js-form-popup-panel-list:first > .js-form-popup-panel-item:last .actions-wrapper .btn[data-attribute="features"]
${tender_form_item_add_feature_btn_locator} =                       jquery=.form-group-popup-panel[data-attribute="items"]:last .js-form-popup-panel-list:first > .js-form-popup-panel-item:last .js-form-popup-panel[data-attribute="features"] .actions-wrapper .btn.js-form-popup-update
${tender_form_item_edit_btn_locator} =                              jquery=.form-group-popup-panel[data-attribute="items"]:last > .panel-heading .js-form-popup-add

#${tender_form_milestones_panel_edit_btn_locator} =                  jquery=[data-url$="#milestones-form-popup"]
${tender_form_milestones_panel_edit_btn_locator} =                  jquery=.form-popup-panel[data-attribute="milestones"]:last > .panel-heading .js-form-popup-update
${milestone_form_popup_add_btn_locator} =                           jquery=.fancybox-is-open [href$="#add-milestones"]
${milestone_form_popup_title_input_locator} =                       jquery=.fancybox-is-open:last .tab-content:first > .tab-pane.active:first [id$="-title"]
${milestone_form_popup_description_input_locator} =                 jquery=.fancybox-is-open:last .tab-content:first > .tab-pane.active:first [id$="-description"]
${milestone_form_popup_percentage_input_locator} =                  jquery=.fancybox-is-open:last .tab-content:first > .tab-pane.active:first [id$="-percentage"]
${milestone_form_popup_code_input_locator} =                        jquery=.fancybox-is-open:last .tab-content:first > .tab-pane.active:first [id$="-code"]
${milestone_form_popup_duration_days_input_locator} =               jquery=.fancybox-is-open:last .tab-content:first > .tab-pane.active:first [id$="-duration_days"]
${milestone_form_popup_duration_type_input_locator} =               jquery=.fancybox-is-open:last .tab-content:first > .tab-pane.active:first [id$="-duration_type"]

${tender_form_lots_panel_edit_btn_locator} =                        jquery=a.btn.btn-default.btn-update.js-form-popup-add
${lot_form_popup_add_btn_locator} =                                 jquery=[href$="#add-milestones"]
${lot_form_popup_title_input_locator} =                             jquery=.fancybox-is-open [id$="-title"]
${lot_form_popup_description_input_locator} =                       jquery=.fancybox-is-open [id$="-description"]
${lot_form_popup_title_en_input_locator} =                          jquery=.fancybox-is-open [id$="-title_en"]
${lot_form_popup_description_en_input_locator} =                    jquery=.fancybox-is-open [id$="-description_en"]
${lot_form_popup_value_amount_input_locator} =                      jquery=.fancybox-is-open [id$="-value_amount-disp"]
##${lot_form_popup_value_amount_input_locator} =                      jquery=.fancybox-is-open [id$="-value_amount"]
${lot_form_popup_value_currency_input_locator} =                    jquery=.fancybox-is-open [id$="-value_currency"]
${lot_form_popup_value_added_tax_input_locator} =                   jquery=.fancybox-is-open [id$="-value_added_tax_included"]
${lot_form_popup_minimalstep_amount_input_locator} =                jquery=.fancybox-is-open [id$="-min_step_amount-disp"]
##${lot_form_popup_minimalstep_amount_input_locator} =                jquery=.fancybox-is-open [id$="-min_step_amount"]
${lot_form_popup_min_step_percentage_amount_input_locator} =        jquery=.fancybox-is-open [id$="-min_step_percentage"]

${tender_form_lot_panel_add_feature_btn_locator} =                  jquery=#Lots .js-form-popup-panel-list:first > .js-form-popup-panel-item:last .actions-wrapper .btn[data-attribute="features"]
${tender_form_lot_panel_update_feature_btn_locator} =               jquery=#Lots #collapseLots0 .js-form-popup-panel-list:first .js-form-hidden-popup-panel:nth(0) a.js-form-popup-update
${tender_form_lot_panel_add_document_btn_locator_tpl} =             jquery=#Lots #collapseLots div[data-title*="%lot_id%"] .actions-wrapper a.js-btn-add-form-popup-panel:last
${tender_form_lot_panel_edit_add_document_btn_locator} =            jquery=#Lots #collapseLots div[data-title*="%lot_id%"] .js-form-hidden-popup-panel:last .actions-wrapper a.js-form-popup-update


${tender_form_procuringEntity_contactPoint_edit_btn_locator} =      jquery=(#tender-form .panel.panel-default.form-popup-panel.js-form-popup-panel .panel-heading .actions-wrapper .js-form-popup-update)[4]
${tender_form_submit_btn_locator} =                                 jquery=#tender-form .js-submit-btn
${tender_created_checker_element_locator} =                         id=tender-part-pjax

# tender view
${tender_view_checker_element_locator} =                            id=tender-general-info
${tender_sync_element_locator} =                                    jquery=#aside-part-pjax .status-label .fa-refresh
${tender_uaid_text_locator} =                                       jquery=#tender-general-info .tender-id .value
${tender_edit_btn_locator} =                                        jquery=#aside-part-pjax a[href*="tender/update"]
${tender_status_value_locator} =                                    jquery=#aside-part-pjax .hidden.opstatus
#елемент проверки загрузки формы в попапе
${popup_dynamic_form_loading_element_locator} =                     jquery=.fancybox-is-open .btn-add .fa-spin
#${add_file_to_form}                                                 xpath=//input[@type='file']
${add_file_to_form_locator} =                                       jquery=.fancybox-is-open input[type$="file"]

# tender index + search
${tender_search_form_locator} =                                     id=tender-filter-form
${tender_search_form_query_input_locator} =                         jquery=#tender-filter-form .dynamic-search-query input
${tender_search_form_result_locator_tpl} =                          jquery=#tender-list .lots__item .lot__characteristic li:contains(%query%)

# -- for viewer --
${tender_title_value_locator} =                                     jquery=#tender-part-pjax > section > div > h1
${tender_description_value_locator} =                               jquery=#tender-part-pjax > section > p
${tender_mainProcurementCategory_value_locator} =                   jquery=#tender-part-pjax .main-procurement-category-source.hidden
${tender_budget_amount_value_locator} =                             jquery=#tender-general-info .budget-amount.hidden
${tender_budget_amount_value_type} =                                float
${tender_tenderID_value_locator} =                                  jquery=#tender-general-info .info-row.tender-id span.value
${tender_milestones_0_code_value_locator} =                         jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:first .code
${tender_milestones_0_title_value_locator} =                        jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:first .title
${tender_milestones_0_percentage_value_locator} =                   jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:first .percentage
${tender_milestones_0_percentage_value_type} =                      float
${tender_milestones_0_duration_days_value_locator} =                jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:first .duration_days
${tender_milestones_0_duration_days_value_type} =                   integer
${tender_milestones_0_duration_type_value_locator} =                jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:first .duration_type
${tender_milestones_1_code_value_locator} =                         jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:nth(1) .code
${tender_milestones_1_title_value_locator} =                        jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:nth(1) .title
${tender_milestones_1_percentage_value_locator} =                   jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:nth(1) .percentage
${tender_milestones_1_percentage_value_type} =                      float
${tender_milestones_1_duration_days_value_locator} =                jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:nth(1) .duration_days
${tender_milestones_1_duration_days_value_type} =                   integer
${tender_milestones_1_duration_type_value_locator} =                jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:nth(1) .duration_type
${tender_milestones_2_code_value_locator} =                         jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:last .code
${tender_milestones_2_title_value_locator} =                        jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:last .title
${tender_milestones_2_percentage_value_locator} =                   jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:last .percentage
${tender_milestones_2_percentage_value_type} =                      float
${tender_milestones_2_duration_days_value_locator} =                jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:last .duration_days
${tender_milestones_2_duration_days_value_type} =                   integer
${tender_milestones_2_duration_type_value_locator} =                jquery=#tender-part-pjax .milestone-list-wrapper .milestone-info-wrapper.hidden.info-wrapper:last .duration_type
${tender_value_amount_value_locator} =                              jquery=#tender-general-info .budget-amount.hidden
${tender_value_amount_value_type} =                                 float
${tender_value_currency_value_locator} =                            jquery=#tender-general-info .budget-currency.hidden
${tender_value_valueAddedTaxIncluded_value_locator} =               jquery=#tender-general-info .budget-tax-included.hidden
${tender_minimalStep_amount_value_locator} =                        jquery=#tender-general-info .minimal-step-source.hidden
${tender_minimalStep_amount_value_type} =                           float
${tender_minimalStepPercentage_value_locator} =                     jquery=#tender-general-info .minimal-step-percentage-source.hidden
${tender_fundingKind_value_locator} =                               jquery=#tender-general-info .funding-kind-source.hidden
${tender_yearlyPaymentsPercentageRange_value_locator} =             jquery=#tender-general-info .yearly-payments-percentage-range-source.hidden
${tender_procuringEntity_name_value_locator} =                      jquery=#tender-part-pjax .info-row.organization span.value > span
${tender_enquiryPeriod_startDate_value_locator} =                   jquery=#tender-part-pjax .info-row.enquiry-period-start-date.hidden
${tender_enquiryPeriod_endDate_value_locator} =                     jquery=#tender-part-pjax .info-row.enquiry-period-end-date.hidden
${tender_tenderPeriod_startDate_value_locator} =                    jquery=#tender-part-pjax .info-row.tender-period-start-date.hidden
${tender_tenderPeriod_endDate_value_locator} =                      jquery=#tender-part-pjax .info-row.tender-period-end-date.hidden
${tender_qualificationPeriod_endDate_value_locator} =               jquery=#tender-general-info .prequalification-period .value .end-date
#negotiation
${tender_cause_value_locator} =                                     jquery=#tender-general-info .cause-source.hidden
${tender_causeDescription_value_locator} =                          jquery=#tender-general-info .cause-description .value

${tender_items_0_description_value_locator} =                       jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .description
#${tender_items_0_description_value_locator} =                       jquery=#tender-part-pjax .tabs__pane--visible .pseudo-table .item-item-wrapper .textvalue.hidden
#${tender_items_0_description_value_locator} =                       jquery=execute javascript  return $('#tender-part-pjax .tabs__pane--visible .pseudo-table .item-item-wrapper').attr("data-title")

#lots
${tender_lot_switch_tabs_lot_btn_locator_tpl}                       jquery=#lots .tabs__list .tabs__item span.tabs__tab-big-text:contains("%lot_id%")
${tender_lot_1_tabs_item_btn_locator}                               jquery=#lots .tabs__item:first > a
${tender_lot_title_value_locator} =                                 jquery=#lots .tabs__content .tabs__pane--visible > span div.textvalue:first
${tender_lot_description_value_locator} =                           jquery=#lots .tabs__content .tabs__pane--visible > span div.textvalue:last
#${tender_lot_description_value_locator} =                           jquery=#lots .tabs__content .tabs__pane--visible #text-modal-description div.textvalue
${tender_lot_value_amount_value_locator} =                          jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lot_value_amount_value_type} =                             float
${tender_lot_value_currency_value_locator} =                        jquery=#tender-general-info .budget-currency.hidden
${tender_lot_value_value_added_tax_included_value_locator} =        jquery=#lots .tabs__content .tabs__pane--visible .budget .value
${tender_lot_minimal_step_currency_value_locator} =                 jquery=#lots .tabs__content .tabs__pane--visible .minimal-step .value
${tender_lot_minimal_step_amount_value_locator} =                   jquery=#lots .tabs__content .tabs__pane--visible .minimal-step-source.hidden
${tender_lot_minimal_step_amount_value_type} =                      float
${tender_lot_minimal_step_amount_currency_value_locator} =          jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lot_minimal_step_amount_value_added_tax_included_value_locator} =      jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lot_minimal_step_value_added_tax_included_value_locator} =      jquery=#lots .tabs__content .tabs__pane--visible .minimal-step .value

##### BOF - TMP #####
${tender_lot_0_title_value_locator} =                               jquery=#lots .tabs__content .tabs__pane--visible > span div.textvalue.hidden
${tender_lot_0_value_amount_value_locator} =                        jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lot_0_value_amount_value_type} =                           float
${tender_lot_0_lots_0_description_value_locator} =                  jquery=#lots .tabs__content .tabs__pane--visible > span div.textvalue.hidden
${tender_lot_0_value_currency_value_locator} =                      jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lot_0_value_value_added_tax_included_value_locator} =      jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lot_0_minimal_step_amount_value_locator} =                 jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lot_0_minimal_step_amount_value_type} =                    float
${tender_lot_0_lot_0_minimal_step_amount_currency_value_locator} =  jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lot_0_lot_0_minimal_step_amount_value_added_tax_included_value_locator} =      jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_form_lots_edit_lot1_btn_locator} =                         jquery=#Lots #collapseLots #Lots0 .actions-wrapper a.btn.btn-default.btn-update.js-form-popup-update:first
${tender_form_lots_add_item_btn_locator} =                          jquery=#Lots #collapseLots #Lots0 .actions-wrapper a.js-form-popup-add
${tender_form_lots_remove_item_btn_locator_tpl} =                   jquery=#collapseLots0 .js-form-popup-panel[data-title*="%item_id%"] .actions-wrapper .js-form-popup-remove
${tender_lots_remove_item_form_submit_success_msg} =                Ви дійсно бажаєте видалити цей елемент?
#${not_alert_opened_close_btn_locator} =                             jquery=.animated-content .js-btn-confirm
${not_alert_opened_close_btn_locator} =                             $('.animated-content .js-btn-confirm').trigger("click")
${tender_form_lots_add_item_reporting_btn_locator} =                jquery=.form-group-popup-panel[data-attribute="items"]:last #Items0 .js-form-popup-update
##### EOF - TMP #####

#item
${tender_item_1_tabs_item_btn_locator}                              jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0)
${tender_item_2_tabs_item_btn_locator}                              jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1)
${tender_item_3_tabs_item_btn_locator}                              jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(2)

${tender_form_general_panel_update_award_reporting_btn_locator} =   jquery=#Award .js-form-popup-update
${tender_form_general_panel_update_award_negotiation_btn_locator} =   jquery=.js-form-popup-panel [data-attribute="awards"] .actions-wrapper .js-form-popup-update
${tender_form_general_panel_add_award_negotiation_btn_locator} =    jquery=.modal.modal-form [href="#add-awards"]

#add\remove feature
#${tender_form_features_panel_edit_btn_locator} =                    jquery=.fancybox-content [href$="#add-features"]
${tender_form_general_panel_update_feature_btn_locator} =           jquery=#collapseGeneral .js-form-popup-update:nth(0)
${tender_update_feature_tender_btn_locator} =                       jquery=#collapseGeneral .js-form-popup-update:nth(0)
${tender_update_feature_lot_btn_locator} =                          jquery=#collapseLots #Lots0 #collapseLots0 .js-form-hidden-popup-panel .js-form-popup-panel[data-attribute*="features"] .actions-wrapper .js-form-popup-update:last
${tender_update_feature_item_btn_locator} =                         jquery=#collapseLots #Lots0 #collapseLots0 .js-form-hidden-popup-panel:nth(0) .actions-wrapper .js-form-popup-update:nth(0)
${tender_feature_dell_btn_locator} =                                jquery=.fancybox-is-open .nav.nav-pills.js-nav.allow-empty .fa.fa-times:last
${tender_feature_form_submit_success_msg} =                         Ви впевнені що бажаєте видалити поточний неціновий критерій?
${tender_feature_dell_submit_btn_locator} =                         jquery=.animated-content .js-btn-confirm

${tender_form_general_tender_plan_id_locator} =                     jquery=[id$="form-plan_id"]
${tender_feature_switch_dell_btn_locator_tpl} =                     jquery=.fancybox-is-open .nav.nav-pills.js-nav.allow-empty li[data-title*="%feature_id%"] .js-dynamic-form-remove .fa.fa-times
#${tender_feature_switch_dell_btn_locator_tpl} =                     $('.fancybox-is-open .nav.nav-pills.js-nav.allow-empty li[data-title*="%feature_id%"]  a[href*="#features"]').click()

#award reporting
${tender_form_award_organization_name_locator} =                    jquery=[id$="-award_organization_name"]
${tender_form_award_organization_identifier_code_locator} =         jquery=[id$="-award_organization_identifier_code"]
${tender_form_award_organization_scale_locator} =                   jquery=[id$="-award_organization_scale"]
${tender_form_award_organization_region_id_locator} =               jquery=[id$="-award_organization_region_id"]
${tender_form_award_organization_postal_code_locator} =             jquery=[id$="-award_organization_postal_code"]
${tender_form_award_organization_locality_locator} =                jquery=[id$="-award_organization_locality"]
${tender_form_award_organization_street_address_locator} =          jquery=[id$="-award_organization_street_address"]
${tender_form_award_organization_contact_point_name_locator} =      jquery=[id$="-award_organization_contact_point_name"]
${tender_form_award_organization_contact_point_email_locator} =     jquery=[id$="-award_organization_contact_point_email"]
${tender_form_award_organization_contact_point_phone_locator} =     jquery=[id$="-award_organization_contact_point_phone"]
${tender_form_award_budget_locator} =                               jquery=[id$="-award_value_amount"]

#stage2button
${tender_stage2_open_btn_locator} =                                 jquery=#aside-part-pjax a[href*="/tender/confirm-stage2"]
${tender_stage2_submit_success_msg} =                               Ви впевнені що бажаєте підтвердити готовність переходу до другого етапу?
${tender_stage2_submit_success_btn_locator} =                       jquery=.jconfirm-box.animated-content .js-btn-confirm
${tender_stage2_submit_js_success_btn_locator} =                    $('.jconfirm-box.animated-content .js-btn-confirm').click()
${tender_stage2_submit_alert_success_msg} =                         Підтвердження успішно надане.
#search
${tender_form_search_btn_locator} =                                 jquery=#DymamicSearch .dynamic-search-submit .js-submit-btn

${popup_opened_content_success_locator} =                           Відмінити
${tender_form_general_panel_edit_btn_locator} =                     jquery=#General #headingGeneral .actions-wrapper .js-form-popup-update
${tender_form_general_panel_draft_mode_input_locator} =             jquery=[id*="-draft_mode"]
${tender_form_general_panel_document_stage2_input_locator} =        jquery=#collapseGeneral .actions-wrapper .js-btn-add-form-popup-panel[data-attribute="documents"]
${stage2_form_add_document_type_input_locator} =                    jquery=.js-dynamic-form-content-item:last .document-type select[id*="-document_type"]
${stage2_form_add_document_description_btn_locator} =               jquery=.js-dynamic-form-content-item:last [href$="#edit"]:last
${stage2_form_add_document_description_input_locator} =             jquery=.js-dynamic-form-content-item:last .popover.fade.top.in textarea[id*="-description"].form-control
${stage2_form_add_document_close_description_btn_locator} =         jquery=.js-dynamic-form-content-item:last .popover.fade.top.in [href$="#close"]



