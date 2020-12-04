*** Variables ***

#qualification
${prequalification_form_0_open_btn_locator} =                       jquery=#bids-pjax .pseudo-table__row[qualification-index="0"] a[href*="/tender/prequalification"]
${prequalification_form_1_open_btn_locator} =                       jquery=#bids-pjax .pseudo-table__row[qualification-index="1"] a[href*="/tender/prequalification"]
${prequalification_form_2_open_btn_locator} =                       jquery=#bids-pjax .pseudo-table__row[qualification-index="2"] a[href*="/tender/prequalification"]
${prequalification_form_3_open_btn_locator} =                       jquery=#bids-pjax .pseudo-table__row[qualification-index="3"] a[href*="/tender/prequalification"]
${prequalification_form_-1_open_btn_locator} =                      jquery=#bids-pjax .pseudo-table__row[qualification-negative-index="-1"] a[href*="/tender/prequalification"]
${prequalification_form_-2_open_btn_locator} =                      jquery=#bids-pjax .pseudo-table__row[qualification-negative-index="-2"] a[href*="/tender/prequalification"]
${prequalification_form_last_open_btn_locator} =                    jquery=#bids-pjax .pseudo-table__row[qualification-index-last] a[href*="/tender/prequalification"]
${prequalification_form_approve_open_btn_locator} =                 jquery=.aside__inner a[href*="/tender/prequalification-approve"]
${prequalification_form_accept_input_locator} =                     $('#prequalificationform-decision').val('accept').change()
${prequalification_form_decline_input_locator} =                    $('#prequalificationform-decision').val('decline').change()
${prequalification_form_cancel_input_locator} =                     $('#prequalificationform-decision').val('cancel').change()
${prequalification_form_eligible_input_locator} =                   jquery=#prequalificationform-eligible
${prequalification_form_qualified_input_locator} =                  jquery=#prequalificationform-qualified
${qualification_form_reasons_cancellation_input_locator} =          jquery=.fancybox-is-open .select2-search__field
${prequalification_form_title_cancellation_input_locator} =         $('#prequalificationform-title').val('Тендерна пропозиція не відповідає вимогам тендерної документації').change()
${prequalification_form_description_cancellation_input_locator} =   jquery=#prequalificationform-description

${qualification_form_submit_success_msg} =                          Пропозиція прийнята
${qualification_form_decline_success_msg} =                         Пропозиція відхилена
${qualification_form_cancel_success_msg} =                          Рішення скасоване
${qualification_form_cancell_success_msg} =                         Рішення завантажене, тепер потрібно накласти ЕЦП/КЕП.
${qualification_form_approve_question_msg} =                        Ви впевнені що бажаєте завершити прекваліфікацію і перейти до наступного етапу?
${qualification_form_submit_btn_locator} =                          jquery=.fancybox-is-open .fancybox-content button.btn.btn-success
${qualification_form_approve_submit_btn_locator} =                  jquery=.jconfirm-box-container .btn.btn-default
${qualification_form_approve_success_msg} =                         Прекваліфікація підтверджена, дочекайтесь опублікування на сайті уповноваженого органу.
${qualification_form_approve_js_submit_btn_locator} =                $('.jconfirm-box-container .btn.btn-default').click()
${qualification_agreement_form_approve_submit_btn_locator} =        jquery=.aside__inner a.js-qualification-approve
${qualification_agreement_form_approve_success_msg} =               Кваліфікація підтверджена, дочекайтесь опублікування на сайті уповноваженого органу.
${qualification_agreement_form_approve_question_msg} =              Ви впевнені що бажаєте завершити кваліфікацію і перейти до наступного етапу?

${qualification_form_0_open_btn_locator} =                          jquery=#bids-pjax .pseudo-table__row[award-index="0"] a[href*="/tender/qualification"]
${qualification_form_1_open_btn_locator} =                          jquery=#bids-pjax .pseudo-table__row[award-index="1"] a[href*="/tender/qualification"]
${qualification_form_2_open_btn_locator} =                          jquery=#bids-pjax .pseudo-table__row[award-index="2"] a[href*="/tender/qualification"]
${qualification_form_3_open_btn_locator} =                          jquery=#bids-pjax .pseudo-table__row[award-index="3"] a[href*="/tender/qualification"]
${qualification_form_last_open_btn_locator} =                       jquery=#bids-pjax .pseudo-table__row[award-index-last] a[href*="/tender/qualification"]
${qualification_form_eligible_input_locator} =                      jquery=#qualificationform-eligible
${qualification_form_qualified_input_locator} =                     jquery=#qualificationform-qualified
${qualification_award_form_submit_success_msg} =                    Рішення завантажене, тепер потрібно накласти ЕЦП/КЕП.
${qualification_award_after_ecp_form_submit_success_msg} =          Рішення підтверджене, очікує опублікування на сайті уповноваженого органу.
${qualification_ecp_form_submit_success_msg} =                      ЕЦП/КЕП успішно накладено
#${qualification_ecp_form_submit_success_msg} =                      ЕЦП/КЕП успішно накладено на рішення, тепер потрібно підтвердити рішення.
${qualification_ecp_form_open_locator} =                            jquery=.modal.modal-xs.fancybox-content
${qualification_ecp_check_input_locator} =                          jquery=input[id$="form-signing"]
${qualification_award_form_title_cancellation_input_locator} =      $('#qualificationform-title').val('Тендерна пропозиція не відповідає вимогам тендерної документації').change()
${qualification_award_form_title_decline_input_locator} =           $('#qualificationform-title').val('Переможець відмовився від підписання договору про закупівлю відповідно до вимог тендерної документації або укладення договору про закупівлю').change()
${qualification_form_description_cancellation_input_locator} =      jquery=#qualificationform-description
${qualification_form_approve_open_btn_locator} =                    jquery=.aside__inner a[href*="/tender/qualification-approve"]
${qualification_form_accept_input_locator} =                        $('#qualificationform-decision').val('accept').change()
${qualification_form_decline_input_locator} =                       $('#qualificationform-decision').val('decline').change()
${add_file_to_qualification_form_locator} =                         jquery=.field-qualificationform-documents .js-upload-documents input[type$="file"]:first
${qualification_form_cancel_input_locator} =                        $('#qualificationform-decision').val('cancel').change()
${qualification_form_add_document_type_input_locator} =             jquery=.js-dynamic-form-content-item:last .document-type select[id*="-document_type"]
${qualification_form_add_document_description_btn_locator} =        jquery=.js-dynamic-form-content-item:last [href$="#edit"]:last
${qualification_form_add_document_description_input_locator} =      jquery=.js-dynamic-form-content-item:last .popover.fade.top.in textarea[id*="-description"].form-control
${qualification_form_add_document_close_description_btn_locator} =  jquery=#qualification-documents .js-actions-wrapper:last .popover.fade.top.in [href$="#close"]
#${qualification_form_add_document_close_description_btn_locator} =  jquery=.js-dynamic-form-content-item:last .popover.fade.top.in [href$="#close"]

#award reporting and negotiotion
${award_form_qualified_input_locator} =                             jquery=#qualificationform-qualified
${award_form_negotiation_submit_success_msg} =                      Інформація о постачальниках успішно онвлена.

