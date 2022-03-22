Feature: User login

  Background:
    * url api_base_url
    * path 'auth', 'login'

  @TEST_OF-704
  Scenario: test the compliance of the login api call status code with valid parameters
    Given request { email: "admin@email.com", password: "12345678" }
    When method post
    Then status 201

    * def resp = response

  @TEST_OF-705
  Scenario: Test request failure when HTTP headers are invalid
    Given request { email: "admin@email.com", password: "12345678" }
    And header Content-Type = 'application/xml'
    When method post
    Then status 400


  @TEST_OF-706
  Scenario Outline: test login api call with invalid required request body
    Given request { email: "<email>", password: "<password>" }
    When method post
    Then assert responseStatus == 400 || responseStatus == 401

    Examples:
      | email         | password     |
      | test@test.com | 23opujlllkjh |
      | test@test.com | hddj         |
      | wrong@email   | hddj         |
