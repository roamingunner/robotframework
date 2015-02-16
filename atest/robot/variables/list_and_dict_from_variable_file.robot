*** Settings ***
Suite Setup      Run Tests    ${EMPTY}    variables/list_and_dict_from_variable_file.robot
Force Tags       regression    pybot    jybot
Resource         atest_resource.robot

*** Test Cases ***
Valid list
    Check Test Case    ${TESTNAME}

Valid dict
    Check Test Case    ${TESTNAME}

List is list
    Check Test Case    ${TESTNAME}

Dict is dotted
    Check Test Case    ${TESTNAME}

Dict is ordered
    Check Test Case    ${TESTNAME}

Invalid list
    Check Test Case    ${TESTNAME}
    Verify Error    0    [ LIST__inv_list | not a list ]    \@{inv_list}
    ...    Expected list-like value, got unicode.

Invalid dict
    Check Test Case    ${TESTNAME}
    Verify Error    1    [ DICT__inv_dict | [u'1', u'2', 3] ]    \&{inv_dict}
    ...    Expected dict-like value, got list.

*** Keywords ***
Verify Error
    [Arguments]    ${index}    ${args}    ${var}    ${error}
    ${p1} =    Normalize Path    ${DATADIR}/variables/list_and_dict_from_variable_file.robot
    ${p2} =    Normalize Path    ${DATADIR}/variables/list_and_dict_variable_file.py
    ${error} =    Catenate    Error in file '${p1}':
    ...    Processing variable file '${p2}' with arguments ${args} failed:
    ...    Invalid variable '${var}': ${error}
    Check Log Message    @{ERRORS}[${index}]    ${error}    ERROR