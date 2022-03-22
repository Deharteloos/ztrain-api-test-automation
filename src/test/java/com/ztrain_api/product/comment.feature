Feature: Comment a product

  Background:
    * url api_base_url
    * path 'product', 'comments', 'add'

  @TEST_OF-740
  Scenario Outline: test the call of the api add comment to product with invalid parameters
    * def query = { product_id: '#(product + "<product_id>")', user_id: '#(authInfo.user + "<user_id>")', message: '<message>'}
    Given request query
    And header Authorization = 'Bearer '+ <_token_>
    When method post
    Then assert responseStatus >= 400
    And assert responseStatus < 500

    Examples:
      | _token_!                | product_id | user_id | message       |
      | authInfo.token + 'ENBB' |            |         | Some comments |
      | authInfo.token          | PRODUCT    |         | Some comments |
      | authInfo.token          |            | USER    | Some comments |
      | authInfo.token          |            |         |               |

  @TEST_OF-741
  Scenario: test the api call add comment to product with valid parameters
    Given request { product_id: '#(product)', user_id: '#(authInfo.user)', message: 'This karate product sucks'}
    And header Authorization = 'Bearer '+ authInfo.token
    When method post
    Then status 201