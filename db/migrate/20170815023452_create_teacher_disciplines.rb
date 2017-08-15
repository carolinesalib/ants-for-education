class CreateTeacherDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_table :teacher_disciplines do |t|
      t.string :ieducar_code
      t.string :name
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
