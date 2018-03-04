FactoryBot.define do
  factory :classroom do
    name Faker::Name.name
    ieducar_code Faker::Number.between(1, 2000)

    school { create :school }
    course { create :course }
    serie { create :serie }
  end
end