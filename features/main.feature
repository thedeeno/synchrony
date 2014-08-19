Feature: Realtime Monitoring
  As a manager
  I want to monitor my production floor in realtime
  So I can spot bottlenecks and issues from my desk

  Background:
    Given an available synchrony app

  Scenario: Organizing containers
    Given a manager
    And an admin
    And 6 employees

    When the manager opens her monitor app
    Then the manager should see:
      """
      0 .container
      0 .employee
      0 .location
      """

    When the admin adds 20 containers
    When the admin adds 10 locations
    Then the manager should see:
      """
      20 .container
      10  .location
      """

    When the employees log in
    Then the manager should see 6 employees

    When the employees works until finished
    Then the manager should see 0 containers
