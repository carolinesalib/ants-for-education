class AddColumnsToClassrooms < ActiveRecord::Migration[5.0]
  def change
    add_reference :classrooms, :school, index: true
    add_reference :classrooms, :course, index: true
    add_reference :classrooms, :serie, index: true
    add_column :classrooms, :year, :integer
  end
end
