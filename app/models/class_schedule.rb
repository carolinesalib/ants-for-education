class ClassSchedule < ApplicationRecord
  has_many :class_schedule_steps

  accepts_nested_attributes_for :class_schedule_steps, reject_if: :all_blank, allow_destroy: true
end
