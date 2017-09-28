class FixColumnDisciplineOnClassroomDisciplins < ActiveRecord::Migration[5.0]
  def change
    remove_column :classroom_disciplines, :ieducar_code
    remove_column :classroom_disciplines, :name
    add_reference :classroom_disciplines, :discipline, index: true
  end
end
