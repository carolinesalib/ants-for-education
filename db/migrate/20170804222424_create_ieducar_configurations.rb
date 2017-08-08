class CreateIeducarConfigurations < ActiveRecord::Migration[5.0]
  def change
    create_table :ieducar_configurations do |t|
      t.string :url

      t.timestamps
    end
  end
end
