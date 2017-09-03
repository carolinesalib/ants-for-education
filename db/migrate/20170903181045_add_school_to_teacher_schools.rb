class AddSchoolToTeacherSchools < ActiveRecord::Migration[5.0]
  def change
    add_reference :teacher_schools, :school, foreign_key: true
  end
end
