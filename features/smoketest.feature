Feature: Check if this image works with Behave
  In order to ensure that the image is complete
  As a maintainer
  I want to run the simplest possible test that use Behave and Selenium

  @smoketest
  Scenario: Check if Behave and Selenium works
    Given Running simply python http.server
     When Call root index.html at root url
     Then Success text is returned

