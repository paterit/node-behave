#!/bin/bash

# launch simple http.server to test Behave and Selenium
python -m http.server $HTTP_SERVER_PORT &
behave
