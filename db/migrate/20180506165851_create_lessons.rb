class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.references :discipline, foreign_key: true
      t.references :classroom, foreign_key: true
      t.integer :course_load
      t.integer :credits

      t.timestamps
    end
  end
end
