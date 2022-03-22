#@parallel=false
Feature: Submit cart

  Background:
    * url api_base_url
    * path 'command', 'create'
    * def result = call read('classpath:com/ztrain_api/cart/addToCart.feature@TEST_OF-728')

  @TEST_OF-734
  Scenario Outline: test the submit command api call with invalid parameters
    * def query =
    """
    {
      "user_id": '#(authInfo.user + "<user_id>")',
      "address": "Mbanga",
      "card": {
          "number": <number>,
          "exp_month": <exp_month>,
          "exp_year": <exp_year>,
          "cvc": "<cvc>"
      }
    }
    """
    Given header Authorization = 'Bearer '+ <_token_>
    And request query
    When method post
    Then match [400, 401, 402] contains responseStatus

    Examples:
      | _token_!                | user_id | number            | exp_month | exp_year | cvc   |
      | authInfo.token + 'ENBB' |         | 4242424242424242  | 1         | 2025     | 314   |
      | authInfo.token          | USER    | 4242424242424242  | 1         | 2025     | 314   |
      | authInfo.token          |         | 43251868156717600 | 1         | 2025     | 314   |
      | authInfo.token          |         | 4242424242424242  | 13        | 2025     | 314   |
      | authInfo.token          |         | 4242424242424242  | 1         | 2020     | 314   |
      | authInfo.token          |         | 4242424242424242  | 1         | 2025     | 32589 |

  @TEST_OF-735
  Scenario: test the submit command api call with valid parameters
    * def query =
    """
    {
      "user_id": '#(authInfo.user)',
      "address": "Makepe, Douala",
      "card": {
          "number": 4242424242424242,
          "exp_month": 12,
          "exp_year": 2025,
          "cvc": "314"
      }
    }
    """
    Given header Authorization = 'Bearer '+ authInfo.token
    And request query
    When method post
    Then status 201
    And match response.message == 'Bravo!!! votre commande a été validé'


