# frozen_string_literal: true

class PokemonClient
  include HTTParty

  base_uri 'https://pokeapi.co/api/v2/pokemon'
  POKEMON_COUNT = 1025.freeze # As of 17/04/2024

  def self.pokemon
    get("/#{RandomNumberApiClient.random}")
  end
end
