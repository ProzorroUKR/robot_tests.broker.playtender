*** Variables ***

${agreement_search_form_locator} =                                  id=agreement-filter-form
${agreement_search_form_query_input_locator} =                      jquery=#agreement-filter-form .dynamic-search-query input
${agreement_search_form_result_locator_tpl} =                       jquery=#agreement-list .lots__item .lot__characteristic li:contains(%query%)

# agreement view
${agreement_view_checker_element_locator} =                         id=agreement-general-info
${agreement_sync_element_locator} =                                 jquery=#aside-part-pjax .status-label .fa-refresh
${agreement_uaid_text_locator} =                                    jquery=#agreement-general-info .agreement-id .value
${agreement_edit_btn_locator} =                                     jquery=#aside-part-pjax a[href*="agreement/update"]
${agreement_status_value_locator} =                                 jquery=#aside-part-pjax .hidden.opstatus
#елемент проверки загрузки формы в попапе
#${popup_dynamic_form_loading_element_locator} =                     jquery=.fancybox-is-open .btn-add .fa-spin
${agreement_changes_0_status_value_locator} =                       jquery=.tabs__pane.tabs__pane--visible[id*="tab-agreement-change"] .agreement-contract-info-wrapper.info-wrapper .info-row.status.hidden
${agreement_changes_0_rationaleType_value_locator} =                jquery=.tabs__pane.tabs__pane--visible[id*="tab-agreement-change"] .agreement-contract-info-wrapper.info-wrapper .info-row.rationale-type span.value
${agreement_changes_0_rationale_value_locator} =                    jquery=.tabs__pane.tabs__pane--visible[id*="tab-agreement-change"] .agreement-contract-info-wrapper.info-wrapper .info-row.rationale span.value

${agreement_changes_0_modifications_0_itemId_value_locator} =       jquery=.tabs__pane.tabs__pane--visible[id*="tab-agreement-change"] .agreement-contract-info-wrapper.info-wrapper .info-row.modification0-itemId.hidden
${agreement_changes_0_modifications_0_addend_value_locator} =       jquery=.tabs__pane.tabs__pane--visible[id*="tab-agreement-change"] .agreement-contract-info-wrapper.info-wrapper .info-row.modification0-factor.hidden

${agreement_changes_1_rationaleType_value_locator} =                jquery=.tabs__pane[id*="tab-agreement-change"]:nth(1) .agreement-contract-info-wrapper.info-wrapper .info-row.rationale-type span.value
${agreement_changes_1_rationale_value_locator} =                    jquery=.tabs__pane[id*="tab-agreement-change"]:nth(1) .agreement-contract-info-wrapper.info-wrapper .info-row.rationale span.value

${agreement_changes_1_modifications_0_itemId_value_locator} =       jquery=.tabs__pane[id*="tab-agreement-change"]:nth(1) .agreement-contract-info-wrapper.info-wrapper .info-row.modification0-itemId.hidden
${agreement_changes_1_modifications_0_factor_value_locator} =       jquery=.tabs__pane[id*="tab-agreement-change"]:nth(1) .agreement-contract-info-wrapper.info-wrapper .info-row.modification0-factor.hidden
${agreement_changes_1_status_value_locator} =                       jquery=.tabs__pane[id*="tab-agreement-change"]:nth(1) .agreement-contract-info-wrapper.info-wrapper .info-row.status.hidden

${agreement_changes_2_rationaleType_value_locator} =                jquery=.tabs__pane[id*="tab-agreement-change"]:nth(2) .agreement-contract-info-wrapper.info-wrapper .info-row.rationale-type span.value
${agreement_changes_2_rationale_value_locator} =                    jquery=.tabs__pane[id*="tab-agreement-change"]:nth(2) .agreement-contract-info-wrapper.info-wrapper .info-row.rationale span.value

${agreement_changes_2_modifications_0_itemId_value_locator} =       jquery=.tabs__pane[id*="tab-agreement-change"]:nth(2) .agreement-contract-info-wrapper.info-wrapper .info-row.modification0-itemId.hidden
${agreement_changes_2_modifications_0_factor_value_locator} =       jquery=.tabs__pane[id*="tab-agreement-change"]:nth(2) .agreement-contract-info-wrapper.info-wrapper .info-row.modification0-factor.hidden
${agreement_changes_2_status_value_locator} =                       jquery=.tabs__pane[id*="tab-agreement-change"]:nth(2) .agreement-contract-info-wrapper.info-wrapper .info-row.status.hidden

${agreement_changes_3_rationaleType_value_locator} =                jquery=.tabs__pane[id*="tab-agreement-change"]:nth(3) .agreement-contract-info-wrapper.info-wrapper .info-row.rationale-type span.value
${agreement_changes_3_rationale_value_locator} =                    jquery=.tabs__pane[id*="tab-agreement-change"]:nth(3) .agreement-contract-info-wrapper.info-wrapper .info-row.rationale span.value

${agreement_changes_3_modifications_0_itemId_value_locator} =       jquery=.tabs__pane[id*="tab-agreement-change"]:nth(3) .agreement-contract-info-wrapper.info-wrapper .info-row.itemid span.value
${agreement_changes_3_modifications_0_factor_value_locator} =       jquery=.tabs__pane[id*="tab-agreement-change"]:nth(3) .agreement-contract-info-wrapper.info-wrapper .info-row.modification0-factor.hidden
${agreement_changes_3_status_value_locator} =                       jquery=.tabs__pane[id*="tab-agreement-change"]:nth(3) .agreement-contract-info-wrapper.info-wrapper .info-row.status.hidden

${agreement_form_refresh_success_msg} =                             Рамкова угода оновлена.
${agreement_form_refresh_btn_locator} =                             jquery=#agreement-general-info a[href*="/utils/agreement-sync"]
