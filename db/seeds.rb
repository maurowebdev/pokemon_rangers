# MUST HAVE 3. Prefill the public elements with a list you built previously
Incident.destroy_all
Ranger.destroy_all

30.times do
  Ranger.create(
    email: Faker::Internet.email,
    password: '1234567A@b',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    identification_number: Faker::Number.number(digits: 10)
  )
end

puts 'Created Rangers!'

Ranger.all.each do |ranger|
  4.times do
    ranger.incidents.create(
      location: Faker::Games::Pokemon.location,
      occurrence_date: Faker::Date.between(to: Date.today, from: 6.months.ago),
      description: "A #{ Faker::Job.title } was afflicted by #{ Faker::Games::Pokemon.move }",
      public_incident: [true, false].sample
    )
  end
end

puts 'Created Incidents'
