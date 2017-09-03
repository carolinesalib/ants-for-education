class AddPeriodToTeacherSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :teacher_schools, :period, :integer
  end
end
