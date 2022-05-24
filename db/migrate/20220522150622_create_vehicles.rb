# frozen_string_literal: true

class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :name, null: false
      t.string :vehicle_type, null: false
      t.float :length_value, null: false
      t.string :length_type, null: false
      t.references :person, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
