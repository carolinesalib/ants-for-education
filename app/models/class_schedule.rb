class ClassSchedule < ApplicationRecord
  has_many :steps

  accepts_nested_attributes_for :steps
end
