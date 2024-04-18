FactoryBot.define do
  factory :ranger do
    email { Faker::Internet.email }
    password { '1234567A@b' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    identification_number { Faker::Number.number(digits: 10) }
  end
end
