FactoryBot.define do
  factory :serie do
    name Faker::Name.name
    course_load 900
    ieducar_code Faker::Number.between(1, 2000)
  end
end