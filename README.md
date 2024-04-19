# POKEREADME
```
* Ruby version: 3.2.1
```

* Configuration:
  - Prerrequisites:
    * `ruby 3.2.1` or superior
    * `rails 7.1.3` or superior
    * `bundler 2.4.6` or superior

* Database creation
  - To create the database, load the schema, and initialize it with the seed data run:
    ```
    rails db:setup
    ```
* How to run the test suite
    - Setup the database with
    ```
    rails db:setup RAILS_ENV=test
    ```
    - And then run
    ```
    rspec
    ```
* Services (job queues, cache servers, search engines, etc.)
    - Up to this point, if everything went smoothly you should be able to sign up, sign in, create incidents
    and check open wild pokemon cases. 💪🏼

* Finally turn on the server and bind it to 0.0.0.0
  ```
  bin/rails s -b 0.0.0.0
  ```
