class RemoveIeducarCodeFromTeacherSchools < ActiveRecord::Migration[5.0]
  def change
    remove_column :teacher_schools, :ieducar_code, :string
  end
end
