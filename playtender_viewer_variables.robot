*** Variables ***

#features
${tender_features_title_value_locator_tpl} =                        jquery=#lots .tabs__pane--visible .feature-list-wrapper [data-title*="%feature_id%"] .hidden.info-wrapper .title
${tender_features_description_value_locator_tpl} =                  jquery=#lots .tabs__pane--visible .feature-list-wrapper [data-title*="%feature_id%"] .hidden.info-wrapper .description
${tender_features_featureof_value_locator_tpl} =                    jquery=#lots .tabs__pane--visible .feature-list-wrapper [data-title*="%feature_id%"] .hidden.info-wrapper .featureOf
${tender_features_new_value_locator_tpl} =                          jquery=.info-row.features div[data-title*="%feature_id%"]


#item view
${tender_items_new_value_locator_tpl} =                             jquery=.item-item-wrapper[data-title*="%item_id%"]
${tender_items_description_value_locator_tpl} =                     jquery=#lots .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] div.textvalue
${tender_items_no_lot_description_value_locator_tpl} =              jquery=.pseudo-table .item-item-wrapper[data-title*="%item_id%"] div.textvalue
${tender_items_quantity_value_locator_tpl} =                        jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .quantity-source
${tender_items_quantity_value_type} =                               float
${tender_items_unit_title_value_locator_tpl} =                      jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .unit-title-source
${tender_items_unit_code_value_locator_tpl} =                       jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .unit-code-source
${tender_items_classification_scheme_value_locator_tpl} =           jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .main-classification-scheme
${tender_items_classification_code_value_locator_tpl} =             jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .main-classification-code
${tender_items_classification_description_value_locator_tpl} =      jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .main-classification-description
${tender_items_additional_classification_scheme_value_locator_tpl} =  jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .additional-classification-scheme
${tender_items_additional_classification_code_value_locator_tpl} =  jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .additional-classification-code
${tender_items_additional_classification_description_value_locator_tpl} =  jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .additional-classification-description
${tender_items_delivery_country_value_locator_tpl} =                jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .delivery-country
${tender_items_delivery_region_id_value_locator_tpl} =              jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .delivery-region
${tender_items_delivery_postal_code_value_locator_tpl} =            jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .delivery-postalcode
${tender_items_delivery_locality_value_locator_tpl} =               jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .delivery-locality
${tender_items_delivery_street_address_value_locator_tpl} =         jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .delivery-street-address
${tender_items_delivery_start_date_value_locator_tpl} =             jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .delivery-start-date-source
${tender_items_delivery_end_date_value_locator_tpl} =               jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .delivery-end-date-source
${tender_items_delivery_latitude_value_locator_tpl} =               jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .delivery-latitude
${tender_items_delivery_longitude_value_locator_tpl} =              jquery=.tabs__content .tabs__pane--visible .item-item-wrapper[data-title*="%item_id%"] .item-info-wrapper.hidden.info-wrapper .delivery-longitude

#${tender_item_description_value_locator} =                          jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .textvalue.hidden
${tender_item_description_value_locator} =                          jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .description
${tender_item_description_ru_value_locator} =                       jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper [id$='-description_ru']
${tender_item_description_en_value_locator} =                       jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper [id$='-description_en']
${tender_item_quantity_value_locator} =                             jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .quantity-source
${tender_item_quantity_value_type} =                                float
${tender_item_unit_title_value_locator} =                           jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .unit-title-source
${tender_item_unit_code_value_locator} =                            jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .unit-code-source
${tender_item_classification_scheme_value_locator} =                jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .main-classification-scheme
${tender_item_classification_code_value_locator} =                  jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .main-classification-code
${tender_item_classification_description_value_locator} =           jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .main-classification-description
${tender_item_additional_classification_scheme_value_locator} =     jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .additional-classification-scheme
${tender_item_additional_classification_code_value_locator} =       jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .additional-classification-code
${tender_item_additional_classification_description_value_locator} =  jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .additional-classification-description
${tender_item_delivery_region_id_value_locator} =                   jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-country
${tender_item_delivery_postal_code_value_locator} =                 jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-postalcode
${tender_item_delivery_locality_value_locator} =                    jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-locality
${tender_item_delivery_street_address_value_locator} =              jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-street-address
${tender_item_delivery_start_date_value_locator} =                  jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-start-date-source
${tender_item_delivery_end_date_value_locator} =                    jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-end-date-source
${tender_item_delivery_latitude_value_locator} =                    jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-latitude
${tender_item_delivery_longitude_value_locator} =                   jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-longitude

${tender_lot_item_description_value_locator} =                      jquery=.tabs__content .tabs__pane--visible .item-item-wrapper div.textvalue
${tender_lot_item_quantity_value_locator} =                         jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .quantity-source
${tender_lot_item_quantity_value_type} =                            float
${tender_lot_item_unit_title_value_locator} =                       jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .unit-title-source
${tender_lot_item_unit_code_value_locator} =                        jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .unit-code-source
${tender_lot_item_classification_scheme_value_locator} =            jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .main-classification-scheme
${tender_lot_item_classification_code_value_locator} =              jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .main-classification-code
${tender_lot_item_classification_description_value_locator} =       jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .main-classification-description
${tender_lot_item_additional_classification_scheme_value_locator} =     jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .additional-classification-scheme
${tender_lot_item_additional_classification_code_value_locator} =   jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .additional-classification-code
${tender_lot_item_additional_classification_description_value_locator} =  jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .additional-classification-description
${tender_lot_item_delivery_region_id_value_locator} =               jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-country
${tender_lot_item_delivery_postal_code_value_locator} =             jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-postalcode
${tender_lot_item_delivery_locality_value_locator} =                jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-locality
${tender_lot_item_delivery_street_address_value_locator} =          jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-street-address
${tender_lot_item_delivery_start_date_value_locator} =              jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-start-date-source
${tender_lot_item_delivery_end_date_value_locator} =                jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-end-date-source
${tender_lot_item_delivery_latitude_value_locator} =                jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-latitude
${tender_lot_item_delivery_longitude_value_locator} =               jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(0) .item-info-wrapper.hidden.info-wrapper .delivery-longitude

${tender_procurementMethodType_value_locator} =                     jquery=#aside-part-pjax .aside__inner .opprocurementmethodtype
${tender_complaintPeriod_endDate_value_locator} =                   jquery=#tender-general-info .info-row.complaint-period .end-date
${tender_qualifications_0_status_value_locator} =                   jquery=.pjax-container .pseudo-table__row[qualification-index="0"] .qualification-info-wrapper .status-source
${tender_qualifications_1_status_value_locator} =                   jquery=.pjax-container .pseudo-table__row[qualification-index="1"] .qualification-info-wrapper .status-source

#lots
${tender_lots_0_title_value_locator} =                               jquery=#lots .tabs__list .tabs__item--active .tabs__tab-big-text
${tender_lots_0_description_value_locator} =                         jquery=#lots .tabs__content .tabs__pane--visible > span div:nth(1)
${tender_lots_title_value_locator_tpl} =                             jquery=#lots .tabs__content .tabs__pane--visible > span div.textvalue:first
${tender_lots_description_value_locator_tpl} =                       jquery=#lots .tabs__content .tabs__pane--visible > span div.textvalue.hidden
${tender_lots_value_amount_value_locator_tpl} =                      jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lots_value_amount_value_type} =                             float
${tender_lots_value_currency_value_locator_tpl} =                    jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lots_value_value_added_tax_included_value_locator_tpl} =    jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lots_minimal_step_amount_value_locator_tpl} =               jquery=#lots .tabs__content .tabs__pane--visible .minimal-step-source.hidden
${tender_lots_minimal_step_amount_value_type} =                      float
${tender_lots_minimal_step_amount_currency_value_locator_tpl} =      jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden
${tender_lots_minimal_step_amount_value_added_tax_included_value_locator_tpl} =      jquery=#lots .tabs__content .tabs__pane--visible .budget-source.hidden

#docs and auction
${tender_new_doc_locator_tpl} =                                     jquery=.docs__list .docs__item.js-item .doc__title:contains("%doc_id%")
${tender_new_doc_title_locator_tpl} =                               $('.docs__list .docs__item.js-item:contains("%doc_id%")').attr("data-title")
#${tender_new_doc_locator_tpl} =                                     jquery=.docs__list .docs__item.js-item:first .doc__title:contains("%doc_id%")
${tender_auction_locator} =                                         jquery=#auction-info
${tender_auction_input_locator} =                                   $('#auction-info a[href*="https://auction-staging"]').attr("href")
${tender_auction_belowThreshold_locator} =                          jquery=#aside-part-pjax a[href*="https://auction-staging"]
${tender_auction_belowThreshold_input_locator} =                    jquery=#aside-part-pjax a[href*="https://auction-staging"]
${tender_auction_belowThreshold_value_locator} =                    $('#aside-part-pjax a[href*="https://auction-staging"]').attr("href")
${tender_auctionPeriod_startDate_value_locator} =                   jquery=#tender-general-info .auction-start-date.hidden
${tender_auctionPeriod_endDate_value_locator} =                     jquery=#tender-general-info .auction-end-date.hidden
${tender_lots_0_auctionPeriod_endDate_value_locator} =              jquery=#tender-general-info .auction-end-date.hidden


#wait for status
${tender_status_active_tendering_value_locator} =                   xpath=//*[contains(text(), "active.tendering")]
${tender_status_active_auction_value_locator} =                     xpath=//*[contains(text(), "active.auction")]
${tender_status_active_pre_qualification_value_locator} =           xpath=//*[contains(text(), "active.pre-qualification")]
${tender_status_complete_value_locator} =                           jquery=#aside-part-pjax .hidden.opstatus:contains(complete)
${tender_status_active_stage2_pending_value_locator} =              xpath=//*[contains(text(), "active.stage2.pending")]
${tender_status_active_stage2_waiting_value_locator} =              xpath=//*[contains(text(), "active.stage2.waiting")]
${tender_status_active_complete_value_locator} =                    jquery=#aside-part-pjax .hidden.opstatus:contains(complete)
${tender_status_active_qualification_value_locator} =               xpath=//*[contains(text(), "active.qualification")]

#funders
${tender_funders_0_name_value_locator} =                            jquery=#tender-general-info .funder-organization .value .popup__inner .definitions__list .organization_name.hidden .definitions__value
${tender_funders_0_address_countryName_value_locator} =             jquery=#tender-general-info .funder-organization .value .popup__inner .definitions__list .country.hidden .definitions__value
${tender_funders_0_address_locality_value_locator} =                jquery=#tender-general-info .funder-organization .value .popup__inner .definitions__list .locality.hidden .definitions__value
${tender_funders_0_address_postalCode_value_locator} =              jquery=#tender-general-info .funder-organization .value .popup__inner .definitions__list .postcode.hidden .definitions__value
${tender_funders_0_address_region_value_locator} =                  jquery=#tender-general-info .funder-organization .value .popup__inner .definitions__list .region.hidden .definitions__value
${tender_funders_0_address_streetAddress_value_locator} =           jquery=#tender-general-info .funder-organization .value .popup__inner .definitions__list .street-address.hidden .definitions__value
${tender_funders_0_identifier_id_value_locator} =                   jquery=#tender-general-info .funder-organization .value .popup__inner .definitions__list .identifier_id .definitions__value
${tender_funders_0_identifier_legalName_value_locator} =            jquery=#tender-general-info .funder-organization .value .popup__inner .definitions__list .identifier_legal_name.hidden .definitions__value
${tender_funders_0_identifier_scheme_value_locator} =               jquery=#tender-general-info .funder-organization .value .popup__inner .definitions__list .identifier_scheme.hidden .definitions__value

#negotiation
#${tender_procuringEntity_contactPoint_name_value_locator} =         jquery=#tender-general-info .organization .value .popup__inner .definitions__list .contact-point-name.hidden .definitions__value
#${tender_procuringEntity_contactPoint_telephone_value_locator} =    jquery=#tender-general-info .organization .value .popup__inner .definitions__list .contact-point-phone.hidden .definitions__value
#${tender_procuringEntity_identifier_legalName_value_locator} =      jquery=#tender-general-info .organization .value .popup__inner .definitions__list .identifier_legal_name.hidden .definitions__value
#${tender_procuringEntity_identifier_scheme_value_locator} =         jquery=#tender-general-info .organization .value .popup__inner .definitions__list .identifier_scheme.hidden .definitions__value
${tender_procuringEntity_contactPoint_name_value_locator} =         jquery=#w0tooltip-content > ul > li.definitions__item.contact-point-name.hidden .definitions__value
${tender_procuringEntity_contactPoint_telephone_value_locator} =    jquery=#w0tooltip-content > ul > li.definitions__item.contact-point-phone.hidden .definitions__value
${tender_procuringEntity_identifier_legalName_value_locator} =      jquery=#w0tooltip-content > ul > li.definitions__item.identifier_legal_name.hidden .definitions__value
${tender_procuringEntity_identifier_scheme_value_locator} =         jquery=#w0tooltip-content > ul > li.definitions__item.identifier_scheme.hidden .definitions__value

${tender_procuringEntity_organization_name_value_locator} =         jquery=#w0tooltip-content > ul > li.definitions__item.organization-name.hidden .definitions__value
${tender_procuringEntity_address_countryName_value_locator} =       jquery=#w0tooltip-content > ul > li.definitions__item.country.hidden .definitions__value
${tender_procuringEntity_address_locality_value_locator} =          jquery=#w0tooltip-content > ul > li.definitions__item.locality.hidden .definitions__value
${tender_procuringEntity_address_postalCode_value_locator} =        jquery=#w0tooltip-content > ul > li.definitions__item.postcode.hidden .definitions__value
${tender_procuringEntity_address_region_value_locator} =            jquery=#w0tooltip-content > ul > li.definitions__item.region.hidden .definitions__value
${tender_procuringEntity_address_streetAddress_value_locator} =     jquery=#w0tooltip-content > ul > li.definitions__item.street-address.hidden .definitions__value
${tender_procuringEntity_contactPoint_url_value_locator} =          jquery=#w0tooltip-content > ul > li.definitions__item.url .definitions__value
${tender_procuringEntity_identifier_id_value_locator} =             jquery=#w0tooltip-content > ul > li.definitions__item.identifier_id.hidden .definitions__value

${tender_items_1_description_value_locator} =                       jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .description
${tender_items_1_quantity_value_locator} =                          jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .quantity-source
${tender_items_1_quantity_value_type} =                             float
${tender_items_1_unit_title_value_locator} =                        jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .unit-title-source
${tender_items_1_unit_code_value_locator} =                         jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .unit-code-source
${tender_items_1_classification_scheme_value_locator} =             jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .main-classification-scheme
${tender_items_1_classification_code_value_locator} =               jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .main-classification-code
${tender_items_1_classification_description_value_locator} =        jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .main-classification-description
${tender_items_1_additional_classification_scheme_value_locator} =  jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .additional-classification-scheme
${tender_items_1_additional_classification_code_value_locator} =    jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .additional-classification-code
${tender_items_1_additional_classification_description_value_locator} =  jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .additional-classification-description
${tender_items_1_delivery_country_value_locator} =                  jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .delivery-country
${tender_items_1_delivery_region_id_value_locator} =                jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .delivery-region
${tender_items_1_delivery_postal_code_value_locator} =              jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .delivery-postalcode
${tender_items_1_delivery_locality_value_locator} =                 jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .delivery-locality
${tender_items_1_delivery_street_address_value_locator} =           jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .delivery-street-address
${tender_items_1_delivery_start_date_value_locator} =               jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .delivery-start-date-source
${tender_items_1_delivery_end_date_value_locator} =                 jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .delivery-end-date-source
${tender_items_1_delivery_latitude_value_locator} =                 jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .delivery-latitude
${tender_items_1_delivery_longitude_value_locator} =                jquery=.tabs__content .tabs__pane--visible .pseudo-table__row.item-item-wrapper:nth(1) .item-info-wrapper.hidden.info-wrapper .delivery-longitude


${tender_awards_0_suppliers_0_contactPoint_telephone_value_locator} =  jquery=#bids-pjax .hint__popup_organization_info .definitions__list .contact-point-phone.hidden .definitions__value
${tender_awards_0_suppliers_0_contactPoint_name_value_locator} =    jquery=#bids-pjax .hint__popup_organization_info .definitions__list .contact-point-name.hidden .definitions__value
${tender_awards_0_suppliers_0_contactPoint_email_value_locator} =   jquery=#bids-pjax .hint__popup_organization_info .definitions__list .contact-point-email.hidden .definitions__value
${tender_awards_0_suppliers_0_identifier_scheme_value_locator} =    jquery=#bids-pjax .hint__popup_organization_info .definitions__list .identifier_scheme.hidden .definitions__value
${tender_awards_0_suppliers_0_identifier_legalName_value_locator} =  jquery=#bids-pjax .hint__popup_organization_info .definitions__list .identifier_legal_name.hidden .definitions__value
${tender_awards_0_suppliers_0_address_countryName_value_locator} =  jquery=#bids-pjax .hint__popup_organization_info .definitions__list .country.hidden .definitions__value
${tender_awards_0_suppliers_0_address_locality_value_locator} =     jquery=#bids-pjax .hint__popup_organization_info .definitions__list .locacity.hidden .definitions__value
${tender_awards_0_suppliers_0_address_postalCode_value_locator} =   jquery=#tender-general-info .organization .value .popup__inner .definitions__list .postcode.hidden .definitions__value
${tender_awards_0_suppliers_0_address_region_value_locator} =       jquery=#tender-general-info .organization .value .popup__inner .definitions__list .region.hidden .definitions__value
${tender_awards_0_suppliers_0_address_streetAddress_value_locator} =   jquery=#tender-general-info .organization .value .popup__inner .definitions__list .street-address.hidden .definitions__value

#esco
${tender_NBUdiscountRate_value_locator} =                           jquery=#tender-general-info .nbu-discount-rate-source.hidden
${tender_NBUdiscountRate_value_type} =                              float
${tender_minimalStepPercentage_value_locator} =                     jquery=#tender-general-info .minimal-step-percentage-source.hidden
${tender_minimalStepPercentage_value_type} =                        float
${tender_fundingKind_value_locator} =                               jquery=#tender-general-info .funding-kind-source.hidden
${tender_yearlyPaymentsPercentageRange_value_locator} =             jquery=#tender-general-info .yearly-payments-percentage-range-source.hidden
${tender_yearlyPaymentsPercentageRange_value_type} =                float
${tender_lots_0_minimalStepPercentage_value_locator} =              jquery=#tender-general-info .minimal-step-percentage-source.hidden
${tender_lots_0_minimalStepPercentage_value_type} =                 float
${tender_lots_0_yearlyPaymentsPercentageRange_value_locator} =      jquery=#tender-general-info .yearly-payments-percentage-range-source.hidden
${tender_lots_0_yearlyPaymentsPercentageRange_value_type} =         float

#awards
${tender_awards_0_complaintPeriod_endDate_value_locator} =          jquery=#tender-general-info .complaint-period .value .end-date
${tender_awards_1_complaintPeriod_endDate_value_locator} =          jquery=#tender-general-info .complaint-period .value .end-date
${tender_awards_complaintPeriod_endDate_value_locator} =            jquery=.award-info-wrapper.hidden .complaint-period-end-date
${tender_awards_negotiation_complaintPeriod_endDate_value_locator} =   jquery=#bids-pjax .pseudo-table__cell .end-date
#${tender_awards_complaintPeriod_endDate_value_locator} =            jquery=#tender-contract-form .js-award-complaint-period-wrapper .end-date
${tender_awards_negotiation_documents_btn_locator} =                jquery=[href*="/tender/view-qualification-result-documents?award"]
${tender_awards_negotiation_documents_close_btn_locator} =          jquery=.modal.fade.fancybox-content .modal-footer .btn.btn-default
${tender_awards_0_documents_0_title_value_locator} =                jquery=.doc__table_title a[href*="https://public-docs-staging.prozorro.gov.ua"]
${tender_awards_0_status_value_locator} =                           jquery=.award-info-wrapper.hidden .status-source

#status contract
#${tender_contracts_0_status_value_locator} =                        jquery=#contracts-pjax .tabs__pane--visible .definitions__item--offset-big .badge__text
${tender_contracts_0_status_value_locator} =                        jquery=#contracts-pjax .tabs__pane--visible .status-source.hidden
${tender_contracts_status_active_value_locator} =                   jquery=#contracts-pjax .tabs__pane--visible .status-source.hidden:contains(active)

${wait_msg_contract} =                                              Завантаження контракту буде

#framework_agreement
${tender_maxAwardsCount_value_locator} =                            jquery=#tender-general-info .max-award-count.hidden
${tender_maxAwardsCount_value_type} =                               integer
${tender_agreementDuration_value_locator} =                         jquery=#tender-general-info .agreement-duration
${tender_agreements_0_status_value_locator} =                       jquery=.tabs__pane--visible[id*="tab-agreement-contract"] .status-source.hidden
${tender_agreements_status_active_value_locator} =                  jquery=.tabs__pane--visible[id*="tab-agreement-contract"] .status-source.hidden:contains(active)

${tender_agreements_0_agreementID_value_locator} =                  jquery=#agreement-contracts-list .agreement-info-wrapper.info-wrapper .agreement-id .value
