FactoryBot.define do
  factory :course do
    name Faker::Name.name
    ieducar_code Faker::Number.between(1, 2000)
  end
end