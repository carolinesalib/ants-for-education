class FixColumnDisciplineOnTeacherDisciplins < ActiveRecord::Migration[5.0]
  def change
    remove_column :teacher_disciplines, :ieducar_code
    remove_column :teacher_disciplines, :name
    add_reference :teacher_disciplines, :discipline, index: true
  end
end
