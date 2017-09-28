class Teacher < ApplicationRecord
  has_many :teacher_disciplines
  has_many :teacher_schools

  def course_load
    TimeConverter.new(super).to_s
  end
end
