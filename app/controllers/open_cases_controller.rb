# frozen_string_literal: true

class OpenCasesController < ApplicationController

  def show
    open_case_subject = PokemonClient.pokemon

    render(
      json:
        {
          name: open_case_subject['name'],
          last_knwon_location: Faker::Games::Pokemon.location,
          last_seen: Faker::Date.between(to: Date.today, from: 1.week.ago),
          photo_evidence: open_case_subject['sprites']['front_default'],
          audio_evidence: open_case_subject['cries']['latest'],
          more_info: "https://www.pokemon.com/us/pokedex/#{open_case_subject['name']}"
        }
    )
  end
end
