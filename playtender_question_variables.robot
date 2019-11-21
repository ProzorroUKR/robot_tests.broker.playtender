*** Variables ***

#question
${question_form_open_btn_locator} =                                 jquery=#aside-part-pjax a[href*="/tender/questions"]
${question_open_form_answer_btn_locator_tpl} =                      jquery=#tender-question-list .js-item div[data-title*="%title%"]
${question_open_form_answer_js_btn_locator_tpl} =                   $('#tender-question-list .js-item div[data-title*="%title%"] .btn.btn-default').click()
${question_form_open_form_answer_btn_locator_tpl} =                 jquery=#tender-question-list .js-item div[data-title*="%title%"] .btn.btn-default
${question_form_open_form_answer_input_locator} =                   jquery=.fancybox-is-open .fancybox-content #tender-question-answer-form #questionanswerform-answer
${question_form_answer_submit_btn_locator} =                        jquery=.fancybox-is-open .fancybox-content button.js-submit-btn
${question_form_submit_answer_success_msg} =                        Відповідь на питання успішно надана.
${question_form_create_question_btn_locator} =                      jquery=#aside-part-pjax [data-url*="/tender/question-create"]
${question_form_create_questionform_related_of_input_locator} =     jquery=.fancybox-is-open .fancybox-content #questionform-related_of
${question_form_create_questionform_related_item_input_locator} =   jquery=.fancybox-is-open .fancybox-content #questionform-related_item
${question_form_create_questionform_related_item_input_locator_tpl} =  jquery=.fancybox-is-open .fancybox-content #questionform-related_item option:contains("%type_id%")
${question_form_create_questionform_title_input_locator} =          jquery=.fancybox-is-open .fancybox-content #questionform-title
${question_form_create_questionform_description_input_locator} =    jquery=.fancybox-is-open .fancybox-content #questionform-description
${question_form_submit_success_msg} =                               Запитання створене.
${question_form_create_questionform_related_lot_input_locator} =    jquery=.fancybox-is-open .fancybox-content #questionform-related_lot
${question_form_create_questionform_related_lot_input_locator} =    jquery=.fancybox-is-open .fancybox-content #questionform-related_lot
${question_form_create_questionform_related_lot_input_locator_tpl} =  jquery=.fancybox-is-open .fancybox-content #questionform-related_lot option:contains("%type_id%")
${question_form_open_create_btn_locator} =                           jquery=#tender-part-pjax a[href*="/tender/question-create"]:first

${question_answer_form_answer_input_locator} =                      jquery=#questionanswerform-answer
${question_answer_form_submit_btn_locator} =                        jquery=#tender-question-answer-form .js-submit-btn

#for viewer
${question_answer_value_locator_tpl} =                              jquery=#tender-question-list .js-item div[data-title*="%title%"] .info-row.answer span.value
${question_title_value_locator_tpl} =                               jquery=#tender-question-list .js-item div[data-title*="%title%"] h4.callout__title
${question_description_value_locator_tpl} =                         jquery=#tender-question-list .js-item div[data-title*="%title%"] .info-row.description span.value

${popup_locator} =                                                  jquery=.fancybox-is-open .fancybox-slide--current .fancybox-content

