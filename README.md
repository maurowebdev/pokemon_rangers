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

* API endpoints
  * POST Sign in
    * `https://pokemon-rangers.onrender.com/sign_in`
    - Using Base64 encoding and basic authentication. (ie. encode 'email@mail.com:1234567A@b' and send as 'Basic ###########')
    - The app will return an encrypted token which can be subsequently used as basic bearer token (ie. 'Bearer ###########')
    ```
      {
        "token": "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZXhwIjoxNzEzNDkzMTk3fQ.MUmZTtSOEYmSxCPtjjsmBWyELyoqfaS_Owyc2r9eOdo",
        "exp": "2024-04-19T02:19:57.576Z",
        "email": "email@mail.com"
      }
    ```
    - Tokens expire after 20 minutes
  * POST Sign up
    - `https://pokemon-rangers.onrender.com/sign_up`
    - Examples
      * Request body:
      ```
        {
          "ranger": {
              "email": "jhon@doe.com",
              "password": "1234567A@b",
              "first_name": "Jhon",
              "identification_number": "1233456789"
          }
        }
      ```
      * Response
        ```
        {
          "id": 32,
          "first_name": "Jhon",
          "last_name": null,
          "email": "jhon@doe.com",
          "identification_number": "1233456789",
          "created_at": "2024-04-19T02:09:47.050Z"
        }
        ```

  * Incidents CRUD
    `https://pokemon-rangers.onrender.com/incidents`
    - Examples
      * Response
        ```
          {
            "incident": {
              "id": 3,
              "location": "Dewford Town",
              "occurrence_date": "2023-10-25",
              "description": "A Central Coordinator was afflicted by Sky Attack",
              "public_incident": true,
              "created_at": "2024-04-19T01:02:26.095Z",
              "ranger": {
                "id": 1,
                "first_name": "Mauricio",
                "last_name": "Barros",
                "identification_number": "1234567890"
              }
            }
          }
        ```
  * GET Open cases (random number + random pokemon)
    `https://pokemon-rangers.onrender.com/open_cases`
    - Examples
      * Response
      ```
        {
          "name": "snorlax",
          "last_knwon_location": "Oreburgh City",
          "last_seen": "2024-04-17",
          "photo_evidence": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/143.png",
          "audio_evidence": "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/143.ogg",
          "more_info": "https://www.pokemon.com/us/pokedex/snorlax"
        }
      ```
