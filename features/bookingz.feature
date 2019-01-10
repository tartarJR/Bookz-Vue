Feature: Library Management System Loan Module
  As a library customer
  From the list of books
  I want to extend the loan period of the book that i borrowed from the library if possible

  Scenario: Accepted Loan
    Given the following books in the library
    | title                          | code	   | start_date  | due_date    | num_of_extensions |
    | Programming Phoenix 13         | A       | 2019-01-10  | 2019-01-17  | 0                 |
    | Secret of the Javascript ninja | A       | 2018-12-19  | 2019-01-16  | 4                 |
    And I want to extend the loan period of "1" book from my borrowed books
    When I extend the loan period for this book
    Then I should get an accepted message for succesfull loan

  Scenario: Rejected Loan
      Given the following books in the library
      | title                          | code	   | start_date  | due_date    | num_of_extensions |
      | Programming Phoenix 13         | A       | 2019-01-10  | 2019-01-17  | 0                 |
      | Secret of the Javascript ninja | A       | 2018-12-19  | 2019-01-16  | 4                 |
      And I want to extend the loan period of "2" book from my borrowed books
      When I extend the loan period for this book
      Then I should get a rejected message for unsuccesfull loan
