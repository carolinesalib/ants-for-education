class TeacherDiscipline < ApplicationRecord
  belongs_to :teacher
  belongs_to :discipline
end
