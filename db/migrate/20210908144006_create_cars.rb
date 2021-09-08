class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string     :license_plate,  null: false
      t.string     :car_type,       null: false
      t.boolean    :active,         null: false, default: true
      t.belongs_to :driver,         null: false, index: true, foreign_key: true
      t.timestamps
    end

    add_index :cars, :license_plate, unique: true
  end
end
