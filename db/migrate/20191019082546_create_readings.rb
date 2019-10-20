class CreateReadings < ActiveRecord::Migration[5.2]

  def change 
    create_table :readings do |t|
      t.belongs_to :thermostat, null: false
      t.integer :tracking_number, auto_increment: true, unique: true
      t.decimal :temperature, default: 0
      t.decimal :humidity, default: 0
      t.decimal :battery_charge, default: 0

      t.timestamps
    end
  end

end
