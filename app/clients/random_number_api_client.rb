# frozen_string_literal: true

class RandomNumberApiClient
  include HTTParty

  base_uri 'http://www.randomnumberapi.com/api/v1.0/random'
  default_params min: 1, max: PokemonClient::POKEMON_COUNT

  def self.random
    get('').first
  end
end
