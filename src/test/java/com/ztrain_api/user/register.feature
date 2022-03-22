Feature: Register a user

  Background:
    * url api_base_url
    * path 'user', 'register'
    * def rqBody =
    """
    {
      email: "#('karateka' + Date.now() + '@email.com')",
      password: "12345678",
      adress: "Entree poubelle, Bassong",
      age: 23
    }
    """

  @TEST_OF-711
  Scenario: test the register user api call status code with valid parameters
    Given request rqBody
    When method post
    Then status 201

  @TEST_OF-713
  Scenario: test the compliance of the response when calling the register user api with the valid required parameters
    Given request rqBody
    When method post
    Then match response == { user: '#present', token: '#present' }

  @TEST_OF-714
  Scenario Outline: test the compliance of the response when calling the register user api with the invalid required parameters
    * def query =
    """
    {
      email: "<email>",
      password: "<password>",
      adress: "<address>",
      age: <age>
    }
    """
    Given request query
    When method post
    Then status 400
    And match response == { statusCode: '#present', message: '#present', error: #present }

    Examples:
      | email       | password | address | age |
      | emailfake   | gggg     | 7854    | dix |
      | ne@test.com | gggg     | Mbanga  | 10  |
      | emailfake   | 12345678 | Mbanga  | 10  |

  @TEST_OF-715
  Scenario Outline: test the compliance of the register user api call status code with invalid parameters
    * def query =
    """
    {
      email: "<email>",
      password: "<password>",
      adress: "<address>",
      age: <age>
    }
    """
    Given request query
    When method post
    Then status 400

    Examples:
      | email       | password | address | age |
      | emailfake   | gggg     | 7854    | dix |
      | ne@test.com | gggg     | Mbanga  | 10  |
      | ne@test.com | 12345678 | Mbanga  | dix |
      | emailfake   | 12345678 | Mbanga  | 10  |

  @TEST_OF-726
  Scenario: test the creation of an existing user
    * def usr =
    """
    {
      email: "admin@email.com",
      password: "12345678",
      adress: "Entree poubelle, Bassong",
      age: 15
    }
    """
    Given request usr
    When method post
    Then status 400
    And match response.message == 'user already exists'