#@parallel=false
Feature: Get cart

  Background:
    * url api_base_url
    * path 'cart'

  @TEST_OF-760
  Scenario Outline: test the get all product user to cart api call with invalid Token
    Given path authInfo.user
    And header Authorization = '<_token_>'
    When method get
    Then status 401

    Examples:
      | _token_               |
      | eYSomefaultyy.token__ |

  @TEST_OF-761
  Scenario Outline: test the get all product user to cart api call with invalid user_id
    Given path '<user_id>'
    And header Authorization = 'Bearer '+ authInfo.token
    When method get
    Then status 400

    Examples:
      | user_id               |
      | 7idsnsomeRand0mUser1d |

  @TEST_OF-766
  Scenario: test get the cart of a user
    Given path authInfo.user
    And header Authorization = 'Bearer '+ authInfo.token
    When method get
    Then status 200
