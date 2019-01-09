Feature: Library Borrowing System Loan Module
  As a customer
  I am interested in to keep book from library more days with me
  I want to extend the time for borrowing the book in library

  Scenario: Loan via Exam web page (with accepted)
    Given the following books are in library
    | title                          | code	   | startdate  | duedate    | timeextended |
    | Programming Phoenix 13         | A       | 2018-01-09 | 2018-01-16 | 0            |
    | Secret of the Javascript ninja | A       | 2017-12-19 | 2018-01-16 | 4            |
    And I want to extend the time of "1" book in my borrowing list
    When I extend it
    Then I should receive a accepted message for succesfull operation

  Scenario: Loan via Exam web page (with rejected)
      Given the following books are in library
      | title                          | code	   | startdate  | duedate    | timeextended |
      | Programming Phoenix 13         | A       | 2018-01-09 | 2018-01-16 | 0            |
      | Secret of the Javascript ninja | A       | 2017-12-19 | 2018-01-16 | 4            |
      And I want to extend the time of "2" book in my borrowing list
      When I extend it
      Then I should receive a rejected message for unsuccesfull operation
