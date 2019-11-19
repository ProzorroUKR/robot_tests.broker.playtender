# -*- coding: utf-8 -
import re
import copy
import urllib
import urllib3

import dateutil.parser
from iso8601 import parse_date
from robot.libraries.BuiltIn import BuiltIn
from datetime import datetime, timedelta
import pytz

TZ = pytz.timezone('Europe/Kiev')

def get_library():
    return BuiltIn().get_library_instance('Selenium2Library')


def get_webdriver_instance():
    return get_library()._current_browser()


# return of variable is None
def get_variable_is_none(variable):
    if variable is None:
        return True
    return False


# run specified keyword if condition is not none type
def run_keyword_if_condition_is_not_none(condition, name, *args):
    if get_variable_is_none(condition) == False:
        BuiltIn().run_keyword(name, *args)


# run specified keyword if condition is none type
def run_keyword_if_condition_is_none(condition, name, *args):
    if get_variable_is_none(condition) == True:
        BuiltIn().run_keyword(name, *args)


# return value for *keys (nested) in `element` (dict).
def get_from_dictionary_by_keys(element, *keys):
    if not isinstance(element, dict):
        raise AttributeError('keys_exists() expects dict as first argument.')
    if len(keys) == 0:
        raise AttributeError('keys_exists() expects at least two arguments, one given.')

    _element = element
    for key in keys:
        try:
            _element = _element[key]
        except KeyError:
            return None
    return _element


# returns if element exists on page. optimization
def get_is_element_exist(locator):
    jquery_locator = convert_locator_to_jquery(locator)
    if get_variable_is_none(jquery_locator) == False:
        jquery_locator = jquery_locator.replace('"', '\\"')
        length = get_webdriver_instance().execute_script('return $("' + jquery_locator + '").length;')
        return length > 0

    try:
        get_library()._element_find(locator, None, True)
    except Exception:
        return False
    return True


# convert locator to jquery locator
def convert_locator_to_jquery(locator):
    locator_params = locator.split('=', 1)
    if locator_params[0] == 'id':
        return '#' + locator_params[1]
    if locator_params[0] == 'jquery':
        return locator_params[1]
    if locator_params[0] == 'css':
        return locator_params[1]
    return None


# set scroll to element in view
def set_element_scroll_into_view(locator):
    element = get_library()._element_find(locator, None, True)
    get_webdriver_instance().execute_script(
        'var $el = jQuery(arguments[0]); if($el.length) $el.get(0).scrollIntoView();',
        element
    )


# return text/value by specified locator
def get_value_by_locator(locator):
    element = get_library()._element_find(locator, None, True)
    text = get_webdriver_instance().execute_script(
        'var $element = jQuery(arguments[0]);'
        'if($element.is("input[type=checkbox]")) return $element.is(":checked") ? "1":"0";'
        'if($element.is("input,textarea,select")) return $element.val();'
        'return $element.text();',
        element
    )
    return text


# input text to hidden input
def input_text_to_hidden_input(locator, text):
    element = get_library()._element_find(locator, None, True)
    get_webdriver_instance().execute_script(
        'jQuery(arguments[0]).val("' + text.replace('"', '\\"') + '");',
        element
    )


# select option by label for hidden select
def select_from_hidden_list_by_label(locator, label):
    element = get_library()._element_find(locator, None, True)
    get_webdriver_instance().execute_script(
        'var $option = jQuery("option:contains(' + label.replace('"', '\\"') + ')", arguments[0]);' +
        'if($option.length) jQuery(arguments[0]).val($option.attr("value"));',
        element
    )


# trigger change event for input by locator
def trigger_input_change_event(locator):
    element = get_library()._element_find(locator, None, True)
    get_webdriver_instance().execute_script(
        'var $el = jQuery(arguments[0]); if($el.length) $el.trigger("change");',
        element
    )


# convert all numners to string
def convert_float_to_string(number):
    return repr(float(number))


def convert_esco__float_to_string(number):
    return '{0:.5f}'.format(float(number))


def convert_float_to_string_3f(number):
    return '{0:.3f}'.format(float(number))


# convert any variable to specified type
def convert_to_specified_type(value, type):
    value = "%s" % (value)
    if type == 'integer':
        value = int(value)
    if type == 'float':
        value = float(value)
    return value


# prepare isodate in needed format
def isodate_format(isodate, format):
    iso_dt = parse_date(isodate)
    return iso_dt.strftime(format)


# prepare data
def prepare_procuring_entity_data(data):
    try:
        data['name'] = u"Playtender"
        data.identifier['id'] = u"playtender"
        data.identifier['legalName'] = u"Playtender"
        data.identifier['scheme'] = u"UA-EDR"
        if 'name_en' in data:
            data['name_en'] = u"Playtender"
        if 'legalName_en' in data.identifier:
            data.identifier['legalName_en'] = u"Playtender"
        if 'address' in data:
            data.address['countryName'] = u"Україна"
            data.address['locality'] = u"Київ"
            data.address['postalCode'] = u"01111"
            data.address['region'] = u"місто Київ"
            data.address['streetAddress'] = u"вулиця Тестова, 220, 8"
        if 'contactPoint' in data:
            data.contactPoint['email'] = u"chuzhin@mail.ua"
            data.contactPoint['faxNumber'] = u"+3801111111111"
            data.contactPoint['telephone'] = u"+3801111111111"
            data.contactPoint['name'] = u"Test"
            if 'name_en' in data.contactPoint:
                data.contactPoint['name_en'] = u"Test"
            data.contactPoint['url'] = u"https://playtender.com.ua"
    except Exception:
        raise Exception('data is not a dictionary')


# prepare data
def prepare_buyers_data(data):
    if type(data) is not list:
        raise Exception('data is not a list')

    # preventing console errors about changing buyer data in cases
    if len(data) != 1:
        return

    item = next(iter(data), None)
    item['name'] = u"Playtender"
    item.identifier['id'] = u"playtender"
    item.identifier['legalName'] = u"Playtender"
    item.identifier['scheme'] = u"UA-EDR"


# prepare dictionary from field path + value
def generate_dictionary_from_field_path_and_value(path, value):
    data = dict()
    path_keys_list = path.split('.')
    if len(path_keys_list) > 1:
        key = path_keys_list.pop(0)
        value = generate_dictionary_from_field_path_and_value('.'.join(path_keys_list), value)
        indexRegex = re.compile(r'(\[(\d+)\]$)')
        matchObj = indexRegex.search(key)
        print matchObj
        if matchObj:
            key = indexRegex.sub('', key)
            value['list_index'] = matchObj.group(2)
            value = [value]
        data[key] = value
    else:
        data = dict()
        data[path] = value
    return data


# Percentage conversion
def multiply_hundred(number):
    return number * 100


# prepares data for filling form in easiest way
def prepare_tender_data(data_original):
    # preventing change data in global view
    data = copy.deepcopy(data_original)

    # check if data is for multilot
    if 'lots' not in data:
        return data

    # moves features to its related items
    if 'features' in data:
        i = 0
        l = len(data['features'])
        while i < l:
            if data['features'][i]['featureOf'] == 'lot':
                for lot in data['lots']:
                    if lot['id'] == data['features'][i]['relatedItem']:
                        if 'features' not in lot:
                            lot['features'] = []
                        lot['features'].append(data['features'].pop(i))
                        l = l - 1
                        i = i - 1
                        break
            if data['features'][i]['featureOf'] == 'item':
                for item in data['items']:
                    if item['id'] == data['features'][i]['relatedItem']:
                        if 'features' not in item:
                            item['features'] = []
                        item['features'].append(data['features'].pop(i))
                        l = l - 1
                        i = i - 1
                        break
            i = i + 1

    if 'features' in data:
        if len(data['features']) == 0:
            del data['features']

    # moves items to its related lots
    i = 0
    l = len(data['items'])
    while i < l:
        for lot in data['lots']:
            if lot['id'] == data['items'][i]['relatedLot']:
                if 'items' not in lot:
                    lot['items'] = []
                lot['items'].append(data['items'].pop(i))
                l = l - 1
                i = i - 1
                break
        i = i + 1

    del data['items']

    if 'milestones' not in data:
        return data
    # moves milestones to its related lots
    i = 0
    l = len(data['milestones'])
    while i < l:
        for lot in data['lots']:
            if lot['id'] == data['milestones'][i]['relatedLot']:
                if 'milestones' not in lot:
                    lot['milestones'] = []
                lot['milestones'].append(data['milestones'].pop(i))
                l = l - 1
                i = i - 1
                break
        i = i + 1

    del data['milestones']

    return data


def split_agreementDuration(str, type):
    if type in 'year':
        year_temp = str.split('Y', 1)
        value = year_temp[0].split('P', 1)
    elif type in 'month':
        month_temp = str.split('M', 1)
        value = month_temp[0].split('Y', 1)
    else:
        day_temp = str.split('D', 1)
        value = day_temp[0].split('M', 1)
    return value[1]


def convert_date_to_string_contr(date):
    date = dateutil.parser.parse(date)
    date = date.strftime("%d.%m.%Y %H:%M:%S")
    return date

def get_value_minimalStepPercentage(value):
    value = value / 100
    return value

def set_value_minimalStepPercentage(value):
    value = value * 100
    return value

def convert_esco__float_to_string(number):
    return '{0:.5f}'.format(float(number))

def convert_string_to_float(number):
    return float(number)

def download_file(url, file_name, output_dir):
    urllib.urlretrieve(url, ('{}/{}'.format(output_dir, file_name)))

def parse_complaintPeriod_date(date_string):
    date_str = datetime.strptime(date_string, "%d.%m.%Y %H:%M")
    date_str -= timedelta(minutes=5)
    date = datetime(date_str.year, date_str.month, date_str.day, date_str.hour, date_str.minute, date_str.second,
                    date_str.microsecond)
    date = TZ.localize(date).isoformat()
    return date
