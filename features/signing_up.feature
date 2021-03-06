Feature: Signing up

  Scenario: Unsuccessful signup
    Given a user visits the signup page
    When they submit invalid signup information
    Then they should see an error message

  Scenario: Successful signup
    Given a user visits the signup page
    When the user submits valid signup information
    Then it should create the user