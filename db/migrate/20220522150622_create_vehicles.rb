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

# added foreign key to prevent actions that would destroy links between tables



# ActiveRecord::SubclassNotFound (The single-table inheritance mechanism 
# failed to locate the subclass: 'sailboat'. This error is raised because the column 'type' is reserved for storing the class in case of inheritance. Please rename this column if you didn't intend it to be used for storing the inheritance class or overwrite Vehicle.inheritance_column to use another column for that information.)