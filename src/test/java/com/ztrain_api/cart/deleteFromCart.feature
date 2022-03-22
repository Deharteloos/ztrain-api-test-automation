#@parallel=false
Feature: Delete product from cart

  Background:
    * url api_base_url
    * path 'cart', 'delete'

  @TEST_OF-753
  Scenario: test the api call delete specific product to cart with valid parameters
    * def result = call read('classpath:com/ztrain_api/cart/addToCart.feature@TEST_OF-728')
    Given header Authorization = 'Bearer '+ authInfo.token
    And request { product: '#(product)', user_id: '#(authInfo.user)' }
    When method delete
    Then status 200
    And match response.message == 'product remove cart successfully'

  @TEST_OF-756
  Scenario Outline: test the api call delete specific product to cart with invalid parameters
    * def result = call read('classpath:com/ztrain_api/cart/addToCart.feature@TEST_OF-728')
    Given header Authorization = 'Bearer '+ <_token_>
    And request { product: '#(product + "<product_id>")', user_id: '#(authInfo.user + "<user_id>")' }
    When method delete
    Then match [400, 401] contains responseStatus

    Examples:
      | _token_!                | product_id | user_id |
      | authInfo.token + 'ENBB' |            |         |
      | authInfo.token          | PRODUCT    |         |
      | authInfo.token          |            | USER    |

  @TEST_OF-
  Scenario: Deletion
    * path authInfo.user
    * header Authorization = 'Bearer '+ authInfo.token
    * method delete
    Then status 200