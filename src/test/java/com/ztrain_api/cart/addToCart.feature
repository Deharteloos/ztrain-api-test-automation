#@parallel=false
Feature: Add product to cart

  Background:
    * url api_base_url
    * path 'cart', 'add'
    * configure afterScenario = read('classpath:afterScenario.js')

  @TEST_OF-727
  Scenario Outline: test the call of the api add product to cart with invalid parameters
    * def query = { product: '#(product + "<product_id>")', user_id: '#(authInfo.user + "<user_id>")', quantity: <quantity>}
    Given request query
    And header Authorization = 'Bearer '+ <_token_>
    When method post
    Then assert responseStatus >= 400
    And assert responseStatus < 500

    Examples:
      | _token_!                | product_id | user_id | quantity |
      | authInfo.token + 'ENBB' |            |         | 5        |
      | authInfo.token          | PRODUCT    |         | 15       |
      | authInfo.token          |            | USER    | 25       |
      | authInfo.token          |            |         | 0        |
      | authInfo.token          |            |         | -6       |
      | authInfo.token          |            |         | 0.75     |


  @TEST_OF-728
  Scenario: test the call of the api add product to cart with valid parameters
    * def qty_added = 1
    Given request { product: '#(product)', user_id: '#(authInfo.user)', quantity: #(qty_added) }
    And header Authorization = 'Bearer '+ authInfo.token
    When method post
    Then status 201

  @TEST_OF-733
  Scenario: test the addition of an existing product
    * def addToCart = call read('classpath:com/ztrain_api/cart/addToCart.feature@TEST_OF-728')
    Given request { product: '#(product)', user_id: '#(authInfo.user)', quantity: 2 }
    And header Authorization = 'Bearer '+ authInfo.token
    When method post
    * def cart = call read('classpath:com/ztrain_api/cart/getCart.feature@TEST_OF-766')
    * print cart.response
    * def pd = karate.filter(cart.response, function(x){ return x.product._id == product })[0]
    Then status 201
    And match pd.quantity == 2 + addToCart.qty_added

