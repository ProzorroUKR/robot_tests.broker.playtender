*** Variables ***

#contractform
${contract_form_0_open_btn_locator} =                               jquery=#contracts-pjax a[href*="/tender/contract?contract"]
${contract_contractform_contract_number_input_locator} =            jquery=#contractform-contract_number
${contract_contractform_date_signed_input_locator} =                jquery=#contractform-date_signed
${contract_contractform_date_start_input_locator} =                 jquery=#contractform-date_start
${contract_contractform_date_end_input_locator} =                   jquery=#contractform-date_end
${contract_contractform_submit_btn_locator} =                       jquery=.fancybox-is-open .fancybox-content button.btn.btn-success
${contract_contractform_submit_success_msg} =                       Контракт успішно завантажений
${contract_contractform_amount_input_locator} =                     jquery=#contractform-value_amount
${contract_contractform_amount_net_input_locator} =                 jquery=#contractform-value_amount_net
${contract_contractform_active_submit_success_msg} =                Контракт успішно активовано, дочекайтесь опублікування на сайті уповноваженого органу.
${contract_contractform_value_added_tax_included_locator} =         jquery=#contractform-value_added_tax_included

#contractform document
${add_file_to_contract_contractform_locator} =                      jquery=.field-contractform-documents .js-upload-documents input[type$="file"]:first
${contract_contractform_add_document_type_input_locator} =          jquery=.js-dynamic-form-content-item:last .document-type select[id*="-document_type"]
${contract_contractform_add_document_description_btn_locator} =     jquery=.js-dynamic-form-content-item:last [href$="#edit"]:last
${contract_contractform_add_document_description_input_locator} =   jquery=.js-dynamic-form-content-item:last .popover.fade.top.in textarea[id*="-description"].form-control
${contract_contractform_add_document_close_description_btn_locator} =  jquery=.js-dynamic-form-content-item:last .popover.fade.top.in [href$="#close"]

${contract_active_form_open_btn_locator} =                          jquery=#contracts-pjax a[href*="/tender/contract-activate"]
${contract_active_form_agreement_open_btn_locator} =                jquery=#agreement-contracts-list .tabs__pane.tabs__pane--visible a[href*="/tender/agreement-contract?"]
${contract_next_form_agreement_open_btn_locator} =                  jquery=#agreement-contracts-list .tabs__item.tabs__item--active_next-child a[id*="tab-agreement-contract"]
${contract_agreement_unit_prices_input_locator} =                   jquery=.fancybox-is-open input[id$="agreementcontractform-unit_prices"]
${contract_agreement_active_submit_success_msg} =                   Постачальник успішно підтверджений, триває синхронізація з сайтом уповноваженого органу.
${contract_active_agreement_form_open_btn_locator} =                jquery=.aside__inner a[href*="/tender/agreement?"]
${contract_agreement_agreement_number_input_locator} =              jquery=#agreementform-agreement_number
${contract_agreement_date_signed_input_locator} =                   jquery=#agreementform-date_signed
${contract_agreement_date_start_input_locator} =                    jquery=#agreementform-date_start
${contract_agreement_date_end_input_locator} =                      jquery=#agreementform-date_end
${contract_agreement_submit_success_msg} =                          Угода завантажена, наступний крок - її активація.
${contract_active_agreement_active_form_open_btn_locator} =         jquery=.aside__inner a[href*="/tender/agreement-activate?"]
${contract_agreement_active_submit_success_msg} =                   Угода успішно активована!
