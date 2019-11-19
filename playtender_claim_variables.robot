*** Variables ***

#claim
${claim_page_open_btn_locator} =                                    jquery=#aside-part-pjax a[href*="/tender/complaints"]
${claim_form_open_btn_locator} =                                    jquery=#tender-part-pjax a[href*="/tender/complaint-create"]:first
${claim_form_complaintform_title_input_locator} =                   jquery=.fancybox-is-open .fancybox-content input[id*="complaintform-title"]
${claim_form_complaintform_description_input_locator} =             jquery=.fancybox-is-open .fancybox-content textarea[id*="complaintform-description"]
${claim_form_complaintform_related_of_input_locator} =              jquery=.fancybox-is-open .fancybox-content select[id*="complaintform-related_of"]
${claim_form_complaintform_related_lot_input_locator} =             jquery=.fancybox-is-open .fancybox-content select[id*="complaintform-related_lot"]
${claim_form_complaintform_related_lot_input_locator_tpl} =         jquery=.fancybox-is-open .fancybox-content select[id*="complaintform-related_lot"] option:contains("%type_id%")
${claim_form_complaintform_complaintform_type_input_locator} =      jquery=.fancybox-is-open .fancybox-content select[id*="complaintform-type"]
${claim_form_complaintform_document_btn_locator} =                  jquery=.fancybox-is-open .fancybox-content a[data-url*="/tender/get-complaint-document"]
${claim_form_complaintform_submit_btn_locator} =                    jquery=.fancybox-is-open .fancybox-content button.btn.btn-success
${claim_uaid_text_locator} =                                        jquery=#tender-complaint-list div.item.js-item:first .complaint-id span.value
#${claim_form_submit_success_msg} =                                  Вимога успішно подана
${claim_form_submit_success_msg} =                                  успішно подана

${claim_cancel_submit_success_msg} =                                Вимога/скарга скасована.

#${claim_form_cancel_open_btn_locator_tpl} =                         jquery=#tender-complaint-list div.item.js-item a[href*="/tender/complaint-cancel"]:last
#${claim_form_cancel_open_btn_locator} =                             jquery=#tender-complaint-list div.item.js-item a[href*="/tender/complaint-cancel"]:last
${claim_form_cancellation_reason_input_locator} =                   jquery=#complaintcancelform-cancellation_reason
${claim_form_cancel_open_btn_locator_tpl} =                         jquery=#tender-part-pjax #tender-complaint-list .complaint__item[data-complaint-id*="%complaint_id%"] a[href*="/tender/complaint-cancel"]

${claim_file_link_input_locator_tpl} =                              return $('#tender-complaint-list .js-item div[data-complaint-id*="%complain_id%"] .complaint-info-wrapper .info-row.documents .value a[href*="https://public-docs-sandbox.prozorro.gov.ua"]').attr("href")
${claim_file_name_input_locator_tpl} =                              jquery=#tender-complaint-list .js-item div[data-complaint-id*="%complain_id%"] .complaint-info-wrapper .info-row.documents .value a[href*="https://public-docs-sandbox.prozorro.gov.ua"]

${claim_wrapper_complain_id_value_locator_tpl} =                    jquery=#tender-complaint-pjax .complaint__item:first
#${claim_wrapper_complain_id_value_locator_tpl} =                    jquery=#tender-complaint-pjax .complaint__item[data-title*="%complain_id%"]
${claim_description_value_locator} =                                .complaint-info-wrapper .info-row.description .value
${claim_title_value_locator} =                                      .complaint-info-wrapper .info-row.title .value
${claim_complain_id_value_locator} =                                .complaint-info-wrapper .info-row.complaint-id .value
${claim_status_value_locator} =                                     .complaint-info-wrapper .info-row.status-source.hidden
${claim_resolution_type_value_locator} =                            .complaint-info-wrapper .info-row.resolution-type-source.hidden
${claim_cancellation_reason_value_locator} =                        .complaint-info-wrapper .info-row.cancellation-reason .value
${claim_related_lot_value_locator} =                                .complaint-info-wrapper .info-row.related-item .value
${claim_resolution_value_locator} =                                 .complaint-info-wrapper .info-row.resolution .value
${claim_satisfied_value_locator} =                                  .complaint-info-wrapper .info-row.satisfied .value

${claim_sync_element_locator} =                                     jquery=.synhronized__icon.fa.fa-refresh.fa-spin

${claim_open_form_answer_btn_locator_tpl} =                         jquery=#tender-complaint-list .js-item div[data-complaint-id*="%title%"]
${claim_form_open_form_answer_btn_locator_tpl} =                    jquery=#tender-complaint-list .js-item div[data-complaint-id*="%title%"] .btn.btn-success
${claim_form_resolved_input_locator_tpl} =                          jquery=#tender-part-pjax #tender-complaint-list .complaint__item[data-complaint-id*="%complaint_id%"] a[href*="/tender/complaint-resolve"]
${claim_form_satisfied_input_locator} =                             jquery=.fancybox-is-open .fancybox-content #complaintresolveform-satisfied
${claim_form_satisfied_submit_success_msg} =                        Вимога вирішена, дочекайтесь опублікування на сайті уповноваженого органу.
#formanswer
${claim_form_answer_resolution_value_locator} =                     jquery=#tender-complaint-answer-form #complaintanswerform-resolution
${claim_form_answer_tenderer_action_value_locator} =                jquery=#tender-complaint-answer-form #complaintanswerform-tenderer_action
${claim_form_answer_resolution_type_value_locator} =                jquery=#tender-complaint-answer-form #complaintanswerform-resolution_type
${claim_form_answer_success_btn_locator} =                          jquery=#tender-complaint-answer-form .btn.btn-success
${claim_form_answer_submit_success_msg} =                           Відповідь на вимогу надана, дочекайтесь опублікування на сайті уповноваженого органу.
${claim_form_status_locator_tpl} =                                  .complaint-info-wrapper .info-row.status-source.hidden:contains(%query%)
${claim_form_satisfied_value_locator_tpl} =                         .complaint-info-wrapper .info-row.satisfied .value:contains(%query%)
