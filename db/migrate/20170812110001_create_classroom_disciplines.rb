class CreateClassroomDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_table :classroom_disciplines do |t|
      t.integer :ieducar_code
      t.string :name
      t.time :course_load
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
