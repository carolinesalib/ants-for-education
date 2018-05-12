FactoryBot.define do
  factory :discipline do
    name Faker::Name.name
    ieducar_code Faker::Number.between(1, 2000)
  end
end