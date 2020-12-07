*** Settings ***

Resource                                                        playtender_common.robot
Resource                                                        playtender_variables.robot
Resource                                                        playtender_question.robot
Resource                                                        playtender_claim.robot
Resource                                                        playtender_bid.robot
Resource                                                        playtender_viewer.robot
Resource                                                        playtender_viewer_variables.robot

*** Keywords ***

get value from features
    [Arguments]                                                 ${feature_id}  ${field_name}
    [Documentation]                                             Отримати значення поля field_name з нецінового показника з feature_id в описі для тендера tender_uaid.

    wait until page does not contain element with reloading     ${tender_sync_element_locator}
    ${tender_features_new_value_locator} =                      replace string  ${tender_features_new_value_locator_tpl}  %feature_id%  ${feature_id}
    wait until page contains element with reloading             ${tender_features_new_value_locator}
    ${return_value} =                                           Run Keyword If  'title' == '${field_name}'   Отримати інформацію із нецінового показника title  ${feature_id}
    ...                                                         ELSE IF  'description' == '${field_name}'   Отримати інформацію із нецінового показника description  ${feature_id}
    ...                                                         ELSE IF  'featureOf' == '${field_name}'   Отримати інформацію із нецінового показника featureOf  ${feature_id}
    [return]                                                    ${return_value}

Отримати інформацію із нецінового показника title
    [Arguments]                                                 ${feature_id}
    [Documentation]                                             Отримати значення поля title з нецінового показника з feature_id в описі для тендера tender_uaid.

    ${tender_features_title_value_locator} =                    replace string  ${tender_features_title_value_locator_tpl}  %feature_id%  ${feature_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_features_title_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із нецінового показника description
    [Arguments]                                                 ${feature_id}
    [Documentation]                                             Отримати значення поля description з нецінового показника з feature_id в описі для тендера tender_uaid.

    ${tender_features_description_value_locator} =              replace string  ${tender_features_description_value_locator_tpl}  %feature_id%  ${feature_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_features_description_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із нецінового показника featureOf
    [Arguments]                                                 ${feature_id}
    [Documentation]                                             Отримати значення поля featureOf з нецінового показника з feature_id в описі для тендера tender_uaid.

    ${tender_features_featureof_value_locator} =                replace string  ${tender_features_featureof_value_locator_tpl}  %feature_id%  ${feature_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_features_featureof_value_locator}
    [return]                                                    ${return_value}


get value from item
    [Arguments]                                                 ${item_id}  ${field_name}
    [Documentation]                                             Отримати значення поля field_name з предмету з item_id в описі для тендера tender_uaid.

#    ${return_value} =                                           Run Keyword If  'title' == '${field_name}'   Отримати інформацію із предмету title  ${item_id}
#    ...                                                         ELSE IF  'description' == '${field_name}'   Отримати інформацію із предмету description  ${item_id}
#    ...                                                         ELSE IF  'featureOf' == '${field_name}'   Отримати інформацію із предмету featureOf  ${item_id]}
    ${tender_items_new_value_locator} =                         replace string  ${tender_items_new_value_locator_tpl}  %item_id%  ${item_id}
    wait until page contains element with reloading             ${tender_items_new_value_locator}
    log many  ${item_id}
    Run Keyword And Return If                                   'description' == '${field_name}'   Отримати інформацію із предмету description  ${item_id}
    Run Keyword And Return If                                   'deliveryDate.startDate' == '${field_name}'   Отримати інформацію із предмету deliveryDate.startDate  ${item_id}
    Run Keyword And Return If                                   'deliveryDate.endDate' == '${field_name}'   Отримати інформацію із предмету deliveryDate.endDate  ${item_id}
    Run Keyword And Return If                                   'deliveryAddress.countryName' == '${field_name}'   Отримати інформацію із предмету deliveryAddress.countryName  ${item_id}
    Run Keyword And Return If                                   'deliveryAddress.postalCode' == '${field_name}'   Отримати інформацію із предмету deliveryAddress.postalCode  ${item_id}
    Run Keyword And Return If                                   'deliveryAddress.region' == '${field_name}'   Отримати інформацію із предмету deliveryAddress.region  ${item_id}
    Run Keyword And Return If                                   'deliveryAddress.locality' == '${field_name}'   Отримати інформацію із предмету deliveryAddress.locality  ${item_id}
    Run Keyword And Return If                                   'deliveryAddress.streetAddress' == '${field_name}'   Отримати інформацію із предмету deliveryAddress.streetAddress  ${item_id}
    Run Keyword And Return If                                   'classification.scheme' == '${field_name}'   Отримати інформацію із предмету classification.scheme  ${item_id}
    Run Keyword And Return If                                   'classification.id' == '${field_name}'   Отримати інформацію із предмету classification.id  ${item_id}
    Run Keyword And Return If                                   'classification.description' == '${field_name}'   Отримати інформацію із предмету classification.description  ${item_id}
    Run Keyword And Return If                                   'additionalClassifications[0].scheme' == '${field_name}'   Отримати інформацію із предмету additionalClassifications[0].scheme  ${item_id}
    Run Keyword And Return If                                   'additionalClassifications[0].id' == '${field_name}'   Отримати інформацію із предмету additionalClassifications[0].id  ${item_id}
    Run Keyword And Return If                                   'additionalClassifications[0].description' == '${field_name}'   Отримати інформацію із предмету additionalClassifications[0].description  ${item_id}
    Run Keyword And Return If                                   'unit.name' == '${field_name}'   Отримати інформацію із предмету unit.name  ${item_id}
    Run Keyword And Return If                                   'unit.code' == '${field_name}'   Отримати інформацію із предмету unit.code  ${item_id}
    Run Keyword And Return If                                   'quantity' == '${field_name}'   Отримати інформацію із предмету quantity  ${item_id}
#    [return]                                                    ${return_value}


Отримати інформацію із предмету description
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля description з предмету з item_id в описі для тендера tender_uaid.

    log many  ${item_id}
    ${tender_items_description_value_locator} =                 run keyword if  ${number_of_lots} > 0  replace string  ${tender_items_description_value_locator_tpl}  %item_id%  ${item_id}
    ...                                                         ELSE  replace string  ${tender_items_no_lot_description_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_description_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету deliveryDate.startDate
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля deliveryDate.startDate з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_delivery_start_date_value_locator} =         replace string  ${tender_items_delivery_start_date_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_delivery_start_date_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету deliveryDate.endDate
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля deliveryDate.endDate з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_delivery_end_date_value_locator} =           replace string  ${tender_items_delivery_end_date_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_delivery_end_date_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету deliveryAddress.countryName
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля deliveryAddress.countryName з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_delivery_country_value_locator} =            replace string  ${tender_items_delivery_country_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_delivery_country_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету deliveryAddress.postalCode
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля deliveryAddress.postalCode з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_delivery_postal_code_value_locator} =        replace string  ${tender_items_delivery_postal_code_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_delivery_postal_code_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету deliveryAddress.region
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля deliveryAddress.region з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_delivery_region_id_value_locator} =          replace string  ${tender_items_delivery_region_id_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_delivery_region_id_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету deliveryAddress.locality
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля deliveryAddress.locality з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_delivery_locality_value_locator} =           replace string  ${tender_items_delivery_locality_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_delivery_locality_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету deliveryAddress.streetAddress
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля deliveryAddress.streetAddress з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_delivery_street_address_value_locator} =     replace string  ${tender_items_delivery_street_address_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_delivery_street_address_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету classification.scheme
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля classification.scheme з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_classification_scheme_value_locator} =       replace string  ${tender_items_classification_scheme_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_classification_scheme_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету classification.id
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля classification.id з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_classification_code_value_locator} =         replace string  ${tender_items_classification_code_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_classification_code_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету classification.description
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля classification.description з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_classification_description_value_locator} =   replace string  ${tender_items_classification_description_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_classification_description_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету additionalClassifications[0].scheme
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля additionalClassifications[0].scheme з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_additional_classification_scheme_value_locator} =   replace string  ${tender_items_additional_classification_scheme_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_additional_classification_scheme_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету additionalClassifications[0].id
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля additionalClassifications[0].id з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_additional_classification_code_value_locator} =   replace string  ${tender_items_additional_classification_code_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_additional_classification_code_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету additionalClassifications[0].description
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля additionalClassifications[0].description з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_additional_classification_description_value_locator} =   replace string  ${tender_items_additional_classification_description_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_additional_classification_description_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету unit.name
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля unit.name з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_unit_title_value_locator} =                  replace string  ${tender_items_unit_title_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_unit_title_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету unit.code
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля unit.code з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_unit_code_value_locator} =                   replace string  ${tender_items_unit_code_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_unit_code_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із предмету quantity
    [Arguments]                                                 ${item_id}
    [Documentation]                                             Отримати значення поля quantity з предмету з item_id в описі для тендера tender_uaid.

    ${tender_items_quantity_value_locator} =                    replace string  ${tender_items_quantity_value_locator_tpl}  %item_id%  ${item_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_items_quantity_value_locator}  float
    [return]                                                    ${return_value}

get value from lot
    [Arguments]                                                 ${lot_id}  ${field_name}
    [Documentation]                                             Отримати значення поля field_name з лоту з lot_id в описі для тендера tender_uaid.

    Run Keyword And Return If                                   'title' == '${field_name}'   Отримати інформацію із лоту title  ${lot_id}
    Run Keyword And Return If                                   'description' == '${field_name}'   Отримати інформацію із лоту description  ${lot_id}
    Run Keyword And Return If                                   'value.amount' == '${field_name}'   Отримати інформацію із лоту value.amount  ${lot_id}
    Run Keyword And Return If                                   'minimalStep.amount' == '${field_name}'   Отримати інформацію із лоту minimalStep.amount  ${lot_id}
    Run Keyword And Return If                                   'value.currency' == '${field_name}'   Отримати інформацію із лоту value.currency  ${lot_id}
    Run Keyword And Return If                                   'value.valueAddedTaxIncluded' == '${field_name}'   Отримати інформацію із лоту value.valueAddedTaxIncluded  ${lot_id}
    Run Keyword And Return If                                   'minimalStep.currency' == '${field_name}'   Отримати інформацію із лоту minimalStep.currency  ${lot_id}
    Run Keyword And Return If                                   'minimalStep.valueAddedTaxIncluded' == '${field_name}'   Отримати інформацію із лоту minimalStep.valueAddedTaxIncluded  ${lot_id}
#    Run Keyword And Return If                                   'auctionPeriod.startDate' == '${field_name}'  get text  jquery=#lots .tabs__content .tabs__pane--visible .auction-period .value .start-date
    Run Keyword And Return If                                   'auctionPeriod.startDate' == '${field_name}'  Отримати інформацію із лоту auctionPeriod.startDate  ${lot_id}
    Run Keyword And Return If                                   'auctionPeriod.endDate' == '${field_name}'  Отримати інформацію із лоту auctionPeriod.endDate  ${lot_id}
#    Run Keyword And Return If                                   'auctionPeriod.endDate' == '${field_name}'  get text  jquery=#lots .tabs__content .tabs__pane--visible .auction-period .value .end-date
    Run Keyword And Return If                                   'minimalStepPercentage' == '${field_name}'  Отримати інформацію із лоту minimalStepPercentage  ${lot_id}
    Run Keyword And Return If                                   'fundingKind' == '${field_name}'   Отримати інформацію із лоту fundingKind  ${lot_id}
    Run Keyword And Return If                                   'yearlyPaymentsPercentageRange' == '${field_name}'  Отримати інформацію із лоту yearlyPaymentsPercentageRange  ${lot_id}


Отримати інформацію із лоту title
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля title з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_title_value_locator} =                         replace string  ${tender_lot_title_value_locator_tpl}  %lot_id%  ${lot_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_lot_title_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із лоту description
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля description з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_description_value_locator} =                   replace string  ${tender_lot_description_value_locator_tpl}  %lot_id%  ${lot_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_lot_description_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із лоту value.amount
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля description з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_value_amount_value_locator} =                  replace string  ${tender_lot_value_amount_value_locator_tpl}  %lot_id%  ${lot_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_lot_value_amount_value_locator}  ${tender_lot_value_amount_value_type}
    [return]                                                    ${return_value}

Отримати інформацію із лоту minimalStep.amount
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля featureOf з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_minimal_step_amount_value_locator} =           replace string  ${tender_lot_minimal_step_amount_value_locator_tpl}  %lot_id%  ${lot_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_lot_minimal_step_amount_value_locator}  ${tender_lot_minimal_step_amount_value_type}
    [return]                                                    ${return_value}

Отримати інформацію із лоту value.currency
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля title з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_value_currency_value_locator} =                replace string  ${tender_lot_value_currency_value_locator_tpl}  %lot_id%  ${lot_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_lot_value_currency_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із лоту value.valueAddedTaxIncluded
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля description з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_value_value_added_tax_included_value_locator} =        replace string  ${tender_lot_value_value_added_tax_included_value_locator_tpl}  %lot_id%  ${lot_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_lot_value_value_added_tax_included_value_locator}
    ${return_value} =                                           set variable if  'з ПДВ' in '${return_value}'  ${True}  ${False}
#    ${return_value} =                                           set variable if  ${return_value} == 1  True
    [return]                                                    ${return_value}

Отримати інформацію із лоту minimalStep.currency
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля title з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_minimal_step_currency_value_locator} =                replace string  ${tender_lot_minimal_step_currency_value_locator_tpl}  %lot_id%  ${lot_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_lot_minimal_step_currency_value_locator}
    ${return_value} =                                           set variable if  'UAH' in '${return_value}'  UAH
    [return]                                                    ${return_value}

Отримати інформацію із лоту minimalStep.valueAddedTaxIncluded
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля description з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_value_minimal_step_added_tax_included_value_locator} =        replace string  ${tender_lot_minimal_step_value_added_tax_included_value_locator_tpl}  %lot_id%  ${lot_id}
#    ${return_value} =                                           get value by locator on opened page  ${tender_lot_minimal_step_value_added_tax_included_value_locator}
    ${return_value} =                                           get value by locator on opened page  ${tender_lot_value_value_added_tax_included_value_locator}
    ${return_value} =                                           set variable if  'з ПДВ' in '${return_value}'  ${True}  ${False}
    [return]                                                    ${return_value}

Отримати інформацію із лоту auctionPeriod.startDate
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля featureOf з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_delivery_region_id_value_locator} =          replace string  ${tender_lot_delivery_region_id_value_locator_tpl}  %lot_id%  ${lot_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_auctionPeriod_startDate_value_locator}
#    ${return_value} =                                           parse_complaintPeriod_date    ${return_value}
    [return]                                                    ${return_value}

Отримати інформацію із лоту auctionPeriod.endDate
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля title з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_delivery_locality_value_locator} =           replace string  ${tender_lot_delivery_locality_value_locator_tpl}  %lot_id%  ${lot_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_auctionPeriod_endDate_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із лоту minimalStepPercentage
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля minimalStepPercentage з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_delivery_street_address_value_locator} =     replace string  ${tender_lot_delivery_street_address_value_locator_tpl}  %lot_id%  ${lot_id}
#    ${return_value} =                                           get field_value by field_name on opened page  ${tender_minimalStepPercentage_value_locator}
    ${return_value} =                                           get value by locator on opened page  ${tender_minimalStepPercentage_value_locator}
    ${return_value} =                                           convert_string_to_float  ${return_value}
    [return]                                                    ${return_value}

Отримати інформацію із лоту fundingKind
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля featureOf з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_classification_scheme_value_locator} =       replace string  ${tender_lot_classification_scheme_value_locator_tpl}  %lot_id%  ${lot_id}
    ${return_value} =                                           get value by locator on opened page  ${tender_fundingKind_value_locator}
    [return]                                                    ${return_value}

Отримати інформацію із лоту yearlyPaymentsPercentageRange
    [Arguments]                                                 ${lot_id}
    [Documentation]                                             Отримати значення поля title з лоту з lot_id в описі для тендера tender_uaid.

#    ${tender_lot_classification_code_value_locator} =         replace string  ${tender_lot_classification_code_value_locator_tpl}  %lot_id%  ${lot_id}
#    ${field_name} =                                             set variable  tender.${field_name}.value
#    ${return_value} =                                           get field_value by field_name on opened page  ${tender_yearlyPaymentsPercentageRange_value_locator}
    ${return_value} =                                           get value by locator on opened page  ${tender_yearlyPaymentsPercentageRange_value_locator}
    ${return_value} =                                           convert_string_to_float  ${return_value}
    [return]                                                    ${return_value}

Отримати інформацію із документа title
    [Arguments]                                                 ${doc_id}
    [Documentation]                                             Отримати значення поля title з документу з doc_id в описі для тендера tender_uaid.

#заготовка
    ${tender_new_doc_locator} =                                 replace string  ${tender_new_doc_locator_tpl}  %doc_id%  ${doc_id}
    wait until page contains element with reloading             ${tender_new_doc_locator}

    ${tender_new_doc__title_locator} =                          replace string  ${tender_new_doc_title_locator_tpl}  %doc_id%  ${doc_id}

    ${return_value} =                                           Execute Javascript  return ${tender_new_doc__title_locator}
    ##${return_value} =                                           get text  ${tender_new_doc_locator}
    #${return_value} =                                           get value by locator on opened page  ${tender_new_doc_locator}
    [return]                                                    ${return_value}

wait for tender status
    [Documentation]                                             Очикування відповідного статусу закупівлі, в залежності від кейворда

    Run Keyword If                                              '${TEST_NAME}' == 'Неможливість завантажити документ першим учасником після закінчення прийому пропозицій'  Wait Until Keyword Succeeds  480 s  20 s  Wait For EndEnquire
    Run Keyword If                                              '${TEST_NAME}' == 'Неможливість завантажити документ другим учасником після закінчення прийому пропозицій'  Wait Until Keyword Succeeds  480 s  20 s  Wait For EndEnquire
    Run Keyword If                                              '${TEST_NAME}' == 'Неможливість задати запитання на тендер після закінчення періоду прийому пропозицій'    Wait Until Keyword Succeeds    480 s    20 s    Wait For EndEnquire
    #Run Keyword If                                              '${TEST_NAME}' == 'Неможливість задати запитання на тендер після закінчення періоду уточнень'  Wait Until Keyword Succeeds  480 s  20 s  Wait For EndEnquire
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість подати пропозицію першим учасником'      Wait Until Keyword Succeeds    480 s    20 s    Wait For TenderPeriod
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість подати пропозицію другим учасником'      Wait Until Keyword Succeeds    480 s    20 s    Wait For TenderPeriod
    Run Keyword If                                              '${TEST_NAME}' == 'Відображення дати закінчення періоду блокування перед початком аукціону'    Wait Until Keyword Succeeds    80 s    20 s    Wait For AuctionPeriod
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість підтвердити першу пропозицію кваліфікації'    Wait Until Keyword Succeeds    80 s    20 s    Wait For PreQualificationPeriod
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість підтвердити другу пропозицію кваліфікації'    Wait Until Keyword Succeeds    80 s    20 s    Wait For PreQualificationPeriod
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість дочекатися завершення роботи мосту'    Wait Until Keyword Succeeds    6000 s    20 s    Wait For CompletePeriod
    #cat  Run Keyword If                                              '${TEST_NAME}' == 'Можливість дочекатися початку періоду очікування'    Wait Until Keyword Succeeds    600 s    20 s    Wait For PreQualificationsStandPeriod
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість дочекатися початку періоду очікування'    Wait Until Keyword Succeeds    600 s    20 s    Wait For ActiveStage2Pending
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість перевести тендер в статус очікування обробки мостом'    Wait Until Keyword Succeeds    600 s    20 s    Wait For ActiveStage2Waiting
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість дочекатись дати закінчення прийому пропозицій' and '${SUITE NAME}' == 'Tests Files.Complaints'   Wait Until Keyword Succeeds    800 s    20 s    Wait For NotTenderPeriod
    Run Keyword If                                              '${TEST_NAME}' == 'Можливість дочекатись дати початку періоду кваліфікації' and '${SUITE NAME}' == 'Tests Files.Complaints'   Wait Until Keyword Succeeds    800 s    20 s    Wait For QualificationsStandPeriod
    Run Keyword If                                              '${TEST_NAME}' == 'Відображення статусу успішного завершення тендера'    Wait Until Keyword Succeeds    6000 s    20 s    Wait For CompletePeriod

Wait For EndEnquire
    [Documentation]                                             Очикування статусу закупівлі закінчення обговорення

    Reload Page
    ${return_value} =                                           Get text  ${tender_status_value_locator}
    Log Many  CAT ${return_value}
    Page Should Not Contain Element                             ${tender_status_active_tendering_value_locator}

Wait For TenderPeriod
    [Documentation]                                             Очикування статусу закупівлі початку подачи пропозицій

    Reload Page
    ${return_value} =                                           Get text  ${tender_status_value_locator}
    Log Many  CAT ${return_value}
    Page Should Contain Element                                 ${tender_status_active_tendering_value_locator}

Wait For AuctionPeriod
    [Documentation]                                             Очикування статусу закупівлі аукціон

    Reload Page
    ${return_value} =                                           Get text  ${tender_status_value_locator}
    Log Many  CAT ${return_value}
    Page Should Contain Element                                 ${tender_status_active_auction_value_locator}

Wait For PreQualificationPeriod
    [Documentation]                                             Очикування статусу закупівлі аукціон

    Reload Page
    ${return_value} =                                           Get text  ${tender_status_value_locator}
    Log Many  CAT ${return_value}
    Page Should Contain Element                                 ${tender_status_active_pre_qualification_value_locator}

Wait For CompletePeriod
    [Documentation]                                             Очикування статусу закупівлі завершення

    Reload Page
    ${return_value} =                                           Get text  ${tender_status_value_locator}
    Log Many  CAT ${return_value}
    Page Should Contain Element                                 ${tender_status_complete_value_locator}

Wait For ActiveStage2Pending
    [Documentation]                                             Очикування статусу закупівлі завершення

    Reload Page
    ${return_value} =                                           Get text  ${tender_status_value_locator}
    Log Many  CAT ${return_value}
    Page Should Contain Element                                 ${tender_status_active_stage2_pending_value_locator}

Wait For ActiveStage2Waiting
    [Documentation]                                             Очикування статусу закупівлі завершення

    Reload Page
    ${return_value} =                                           Get text  ${tender_status_value_locator}
    Log Many  CAT ${return_value}
    Page Should Contain Element                                 ${tender_status_active_stage2_waiting_value_locator}

Wait For NotTenderPeriod
    [Documentation]                                             Очикування статусу закупівлі завершення

    Reload Page
    ${return_value} =                                           Get text  ${tender_status_value_locator}
    Log Many  CAT ${return_value}
    Page Should Contain Element                                 ${tender_status_active_tendering_value_locator}

Wait For QualificationsStandPeriod
    [Documentation]                                             Очикування статусу закупівлі завершення кваліфікації

    Reload Page
    ${return_value} =                                           Get text  ${tender_status_value_locator}
    Log Many  CAT ${return_value}
    Page Should Contain Element                                 ${tender_status_active_qualification_value_locator}

Wait For QualificationsPeriodEnd
    [Documentation]                                             Очикування дати завершення кваліфікації закупівлі

    Reload Page
    ${complaintPeriod} =                                        get value by locator on opened page  ${tender_qualificationPeriod_endDate_value_locator}
    Log Many  CAT ${complaintPeriod}
    Run Keyword If                                              '${complaintPeriod}' == ''  input text to exist visible input  ${contract_contractform_date_start_input_locator}  ${date_start}
    :FOR    ${INDEX}    IN RANGE    1    60
    \                                                           Run Keyword If    '${complaintPeriod}' != ''    Exit For Loop
    \                                                           Reload Page
    \                                                           ${complaintPeriod} =  get value by locator on opened page  ${tender_qualificationPeriod_endDate_value_locator}

Отримати інформацію із contracts[0].status
    [Documentation]                                             Отримати значення поля contracts[0].status

#    ${tmp} =                                                    get value by locator on opened page  ${tender_contracts_0_status_value_locator}
#    ${return_value} =                                           Set Variable If  '${tmp}' in 'Підписаний Новий'  active  other
    Run Keyword If                                              '${TEST_NAME}' == 'Відображення статусу підписаної угоди з постачальником переговорної процедури'   Wait Until Keyword Succeeds    800 s    20 s    Wait For contractactive
    Run Keyword If                                              '${TEST_NAME}' == 'Відображення статусу підписаної угоди з постачальником звіту про укладений договір'   Wait Until Keyword Succeeds    800 s    20 s    Wait For contractactive
    Run Keyword If                                              '${TEST_NAME}' == 'Відображення статусу підписаної угоди з постачальником закупівлі'   Wait Until Keyword Succeeds    800 s    20 s    Wait For contractactive
    ${return_value} =                                           get value by locator on opened page  ${tender_contracts_0_status_value_locator}
    [return]                                                    ${return_value}

Wait For contractactive
    [Documentation]                                             Очикування статусу закупівлі початку подачи пропозицій

    Reload Page
    ${return_value} =                                           get value by locator on opened page  ${tender_contracts_0_status_value_locator}
    Page Should Contain Element                                 ${tender_contracts_status_active_value_locator}

Отримати інформацію із awards.complaintPeriod.endDate
    [Documentation]                                             Отримати значення поля awards.complaintPeriod.endDate

    run keyword and ignore error                                Wait Until Keyword Succeeds  600 s  30 s  Wait For complaintPeriodendDate
    ${return_value} =                                           get value by locator on opened page  ${tender_awards_complaintPeriod_endDate_value_locator}
#    ${return_value} =                                           run keyword if  '${mode}' in 'negotiation'  get value by locator on opened page  ${tender_awards_negotiation_complaintPeriod_endDate_value_locator}
#    ...                                                         ELSE  get value by locator on opened page  ${tender_awards_complaintPeriod_endDate_value_locator}
#    ${return_value} =                                           run keyword if  '${mode}' in 'negotiation'  parse_complaintPeriod_date  ${return_value}
#    ...                                                         ELSE  set variable  ${return_value}
    [return]                                                    ${return_value}

Отримати інформацію із complaintPeriod.endDate
    [Documentation]                                             Отримати значення поля complaintPeriod.endDate

    ${return_value} =                                           get value by locator on opened page  ${tender_complaintPeriod_endDate_value_locator}
    [return]                                                    ${return_value}

Wait For complaintPeriodendDate
    [Documentation]                                             Очикування появи дати завершення подачи скарг на кваліфікацію закупівлі в belowThreshold та below_funders

    reload page
    ${complaintPeriod} =                                        get value by locator on opened page  ${tender_awards_complaintPeriod_endDate_value_locator}
    :FOR    ${INDEX}    IN RANGE    1    60
    \                                                           Run Keyword If    '${complaintPeriod}' != ''    Exit For Loop
    \                                                           Reload Page
    \                                                           ${complaintPeriod} =  get value by locator on opened page  ${tender_awards_complaintPeriod_endDate_value_locator}

Отримати інформацію із minimalStep.amount
    [Documentation]                                             Отримати значення поля minimalStep.amount для тендера tender_uaid.

#    ${tender_lot_minimal_step_amount_value_locator} =           replace string  ${tender_lot_minimal_step_amount_value_locator_tpl}  %lot_id%  ${lot_id}
    ${return_value} =                                           run keyword if  ${number_of_lots} > 0  get value by locator on opened page  ${tender_lot_minimal_step_amount_value_locator}  ${tender_lot_minimal_step_amount_value_type}
    ...                                                         ELSE  get value by locator on opened page  ${tender_minimalStep_amount_value_locator}  ${tender_lot_minimal_step_amount_value_type}
    [return]                                                    ${return_value}

Отримати інформацію із awards[0].documents[0].title
    [Documentation]                                             Отримати значення поля minimalStep.amount для тендера tender_uaid.

#    ${tender_lot_minimal_step_amount_value_locator} =           replace string  ${tender_lot_minimal_step_amount_value_locator_tpl}  %lot_id%  ${lot_id}
#    click visible element                                       ${tender_awards_negotiation_documents_btn_locator}
    open popup by btn locator                                   ${tender_awards_negotiation_documents_btn_locator}
    ${return_value} =                                           get value by locator on opened page  ${tender_awards_0_documents_0_title_value_locator}
    click visible element                                       ${tender_awards_negotiation_documents_close_btn_locator}
    [return]                                                    ${return_value}

Wait For stage2button
    [Documentation]                                             Очикування кнопки переводу до другого етапу

    Reload Page
    Page Should Contain Element                                 ${tender_stage2_open_btn_locator}

Отримати інформацію із qualificationPeriod.endDate
    [Documentation]                                             Отримати значення поля qualificationPeriod.endDate

#    run keyword and ignore error                                run keyword if  '${mode}' in 'belowThreshold below_funders'  Wait Until Keyword Succeeds  600 s  30 s  Wait For complaintPeriodendDate
#    run keyword and ignore error                                Wait Until Keyword Succeeds  600 s  30 s  Wait For complaintPeriodendDate
    ${return_value} =                                           get value by locator on opened page  ${tender_qualificationPeriod_endDate_value_locator}
    ${return_value} =                                           parse_complaintPeriod_date  ${return_value}
    [return]                                                    ${return_value}

wait for agreements status active
    [Documentation]                                             Очикування статусу agreements active

    Reload Page
    ${return_value} =                                           get value by locator on opened page  ${tender_agreements_0_status_value_locator}
    Page Should Contain Element                                 ${tender_agreements_status_active_value_locator}

Wait date
  [Arguments]  ${date}
  ${sleep}=  wait_to_date  ${date}
  Run Keyword If  ${sleep} > 0  Sleep  ${sleep}



