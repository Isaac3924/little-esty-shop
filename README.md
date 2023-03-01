# Little Esty Shop

## Background and Description
"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code
- Design an Object Oriented Solution to a problem
- Practice algorithmic thinking
- Work in a group
- Use Pull Requests to collaborate among multiple partners

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL

## Setup
This project requires Ruby 2.7.4.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases
1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

## Summary of work completed
* Create an application where a small business could manage their customer data and web page
* Create advanved routing techniques like namespace and resources
* Create tasks to load data from CSVs into our database
* Work with many to many and one to many relationships to create a normalized databas
* Create complex active record queries to extract specific information from our database

## Potential Future Refactor
* Possibly utilize FactoryBot gem to create normalized test data across all test files

## Authors 
[Antonio King Hunt](https://github.com/4D-Coder) ,
[Bobby Luly](https://github.com/Bobsters986) ,
[Isaac Alter](https://github.com/Isaac3924),
[Jade Stewart](https://github.com/jadekstewart3)