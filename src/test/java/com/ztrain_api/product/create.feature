Feature: Create product

  Background:
    * url api_base_url
    * path 'product', 'create'
    * header Authorization = 'Bearer '+ authInfo.token

  @TEST_OF-719
  Scenario Outline: test the create product api call with invalid parameters
    Given request { name: "<name>", description: "<description>", image: "<image>", price: <price> }
    When method post
    Then match karate.range(400, 499) contains responseStatus

    Examples:
      | name                   | description                                                                                                      | image             | price |
      | Short name             | This is a description for the smartphone Tecno spark 4 air worth more than hundred characters. Tecno Spark 4 Air | https://image.jpg | 120   |
      | Loafers Shoes Cameroon | A short description                                                                                              | https://image.jpg | 10.99 |
      | Loafers Shoes Cameroon | This is a description for the smartphone Tecno spark 4 air worth more than hundred characters. Tecno Spark 4 Air | image url         | 120   |
      | Wholecut Derby Shoeees | This is a description for the smartphone Tecno spark 4 air worth more than hundred characters. Tecno Spark 4 Air | https://image.jpg | -26   |
      | Product name of twenty | This is a description for the smartphone Tecno spark 4 air worth more than hundred characters. Tecno Spark 4 Air | https://image.jpg | 0     |

  @TEST_OF-720
  Scenario: test the create product api call with valid parameters
    * def query =
    """
    {
      name: "#('Oxford Loafers Derby' + Date.now())",
      description: "This is a description for the smartphone Tecno spark 4 air worth more than hundred characters. Tecno Spark 4 Air",
      image: "http://image.jpeg",
      price: 19.98
    }
    """
    Given request query
    When method post
    Then status 201
