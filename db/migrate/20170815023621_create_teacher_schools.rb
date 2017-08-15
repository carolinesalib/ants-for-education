class CreateTeacherSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :teacher_schools do |t|
      t.string :ieducar_code
      t.string :name
      t.time :course_load
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
