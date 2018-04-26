class RenameClassroomDisciplines < ActiveRecord::Migration[5.0]
  def change
    rename_table :classroom_disciplines, :classrooms_disciplines
  end
end
