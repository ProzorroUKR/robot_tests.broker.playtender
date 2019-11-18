*** Variables ***

#bids
${bid_form_open_btn_locator} =                                      jquery=#aside-part-pjax a[href*="/tender/bid"]
${bid_form_remove_btn_locator} =                                    jquery=#aside-part-pjax a[href*="#bid-delete"]
${bid_form_submit_success_msg} =                                    Пропозиція створена
${bid_form_submit_edit_success_msg} =                               Пропозиція відредагована
${bid_form_submit_remove_success_msg} =                             Ви впевнені що бажаєте видали свою пропозицію?
${alert_opened_close_bid_btn_locator} =                             jquery=.animated-content .js-btn-confirm
${bid_form_feature_input_locator_tpl} =                             jquery=.fancybox-is-open .fancybox-content select[id*="%title%-enum"]
${bid_form_feature_value_input_locator_tpl} =                       option[data-weight-source*="%value%"]
#${bid_form_feature_value_input_locator_tpl} =                       jquery=.fancybox-is-open .fancybox-content select[id*="%title%-enum"] option[data-weight-source*="%value%"]
${bid_form_value_amount_input_locator} =                            jquery=.fancybox-is-open .fancybox-content input[id*="-value_amount"]
${bid_form_value_subcontracting_details_input_locator} =            jquery=.fancybox-is-open .fancybox-content textarea[id*="-subcontracting_details"]
${bid_form_value_self_eligible_input_locator} =                     jquery=.fancybox-is-open .fancybox-content input[id*="-self_eligible"]
${bid_form_value_self_qualified_input_locator} =                    jquery=.fancybox-is-open .fancybox-content input[id*="-self_qualified"]
${bid_form_value_yearly_payments_percentage_input_locator} =        jquery=.fancybox-is-open .fancybox-content input[id*="-yearly_payments_percentage"]
${bid_form_value_contract_duration_years_input_locator} =           jquery=.fancybox-is-open .fancybox-content input[id*="-contract_duration_years"]
${bid_form_value_contract_duration_days_input_locator} =            jquery=.fancybox-is-open .fancybox-content input[id*="-contract_duration_days"]
${bid_form_value_annual_costs_reduction_input_locator_tpl} =        jquery=.fancybox-is-open .fancybox-content input[name*="[annual_costs_reduction_%index%]"]

${add_file_to_bid_all_form_locator} =                               jquery=#tender-bid-form .documents-dynamic-forms-wrapper:last .js-upload-documents
${add_file_to_bid_form_locator} =                                   jquery=#tender-bid-form .documents-dynamic-forms-wrapper:last .js-upload-documents input[type$="file"]:first
${bid_form_add_document_all_btn_locator} =                          jquery=#tender-bid-form .documents-dynamic-forms-wrapper:last .js-upload-documents input[type$="file"]:first
${bid_form_add_document_type_input_locator} =                       jquery=#tender-bid-form .documents-dynamic-forms-wrapper:last select[id*="-document_type"]:last
${bid_form_add_document_description_btn_locator} =                  jquery=#tender-bid-form .documents-dynamic-forms-wrapper:last [href$="#edit"]:last
${bid_form_add_document_description_input_locator} =                jquery=#tender-bid-form .documents-dynamic-forms-wrapper:last .popover.fade.top.in textarea[id*="-description"].form-control
${bid_form_add_document_close_description_btn_locator} =            jquery=#tender-bid-form .documents-dynamic-forms-wrapper:last .popover.fade.top.in [href$="#close"]
${bid_form_add_document_confidentiality_input_locator} =            jquery=#tender-bid-form .documents-dynamic-forms-wrapper:last .popover.fade.top.in [id$="-confidentiality"]
${bid_form_submit_btn_locator} =                                    jquery=.fancybox-is-open .fancybox-content button.btn.btn-success
${bid_form_edit_document_all_btn_locator} =                         jquery=.form-documents-group .tab-content .item-wrapper.js-item:last a[href*="#reupload"]

${bid_lotValues_0_value_amount_value_locator} =                     jquery=.fancybox-slide .modal.fancybox-content #tender-bid-form .tab-content .active.js-lot-tab .js-amount-weight-wrapper .input-group .js-amount-input
${bid_lotValues_0_value_amount_value_locator_type} =                float

${bid_popup_locator} =                                              jquery=.fancybox-slide .modal.fancybox-content
