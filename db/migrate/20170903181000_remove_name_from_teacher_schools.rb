class RemoveNameFromTeacherSchools < ActiveRecord::Migration[5.0]
  def change
    remove_column :teacher_schools, :name, :string
  end
end
