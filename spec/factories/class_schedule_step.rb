FactoryBot.define do
  factory :class_schedule_step do
    class_schedule { create :class_schedule }
  end
end