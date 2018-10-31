from selenium import webdriver

BEHAVE_DEBUG_ON_ERROR = False


def before_all(context):
    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    try:
        context.browser = webdriver.Chrome(chrome_options=options)
    except ConnectionResetError: 
        print("Behave->before_all: ConnectionResetError - try again to set context.browser")
        # sometimes it fails with this error. Not sure why.
        context.browser = webdriver.Chrome(chrome_options=options)


def after_all(context):
    context.browser.quit()