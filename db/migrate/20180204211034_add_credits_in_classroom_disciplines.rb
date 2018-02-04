class AddCreditsInClassroomDisciplines < ActiveRecord::Migration[5.0]
  def change
    add_column :classroom_disciplines, :credits, :integer
  end
end
