# frozen_string_literal: true
FactoryBot.define do
  factory :incident do
    location { Faker::Games::Pokemon.location }
    occurrence_date { Faker::Date.between(to: Date.today, from: 6.months.ago) }
    description { "A #{ Faker::Job.title } was afflicted by #{ Faker::Games::Pokemon.move }" }
    ranger_id { nil }
    public_incident { [true, false].sample }
  end
end
