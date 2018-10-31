from behave import *
import requests


@given(u'Running simply python http.server')
def step_impl(context):
    pass


@when(u'Call root index.html at root url')
def step_impl(context):
    context.response = requests.get('http://localhost:8888/')


@then(u'Success text is returned')
def step_impl(context):
    r = context.response
    assert 200 == r.status_code
    assert 'Success! Behave with Selenium work!' in str(r.content)
