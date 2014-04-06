class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.string :core
      t.float :temprature
      t.float :humidity
      t.string :note

      t.timestamps
    end
  end
end
