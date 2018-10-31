Feature: Check if this image works with Behave
  In order to ensure that the image is complete
  As a maintainer
  I want to simplest possible test tha use Behave and Selenium
  by using their specific healtchecks

  @smoketest
  Scenario: Check if Behave and Selenium works
    Given Running simply python http.server
     When Call root index.html at root url
     Then Success text is returned

