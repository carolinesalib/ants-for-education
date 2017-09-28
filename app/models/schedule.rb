class Schedule < ApplicationRecord
  belongs_to :classroom
  belongs_to :teacher
  belongs_to :discipline
  belongs_to :class_schedule

  validates_uniqueness_of :teacher_id, scope: %i[class_schedule_id step]
end
