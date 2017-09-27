class Schedule < ApplicationRecord
  self.primary_keys = :teacher_id, :class_schedule, :step

  belongs_to :classroom
  belongs_to :teacher
  belongs_to :discipline
  belongs_to :class_schedule
end
