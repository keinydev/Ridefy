class CreateDrivers < ActiveRecord::Migration[6.1]
  def change
    create_table :drivers do |t|
      t.string  :first_name,                null: false
      t.string  :last_name,                 null: false
      t.string  :phone,                     null: false
      t.string  :email,                     null: false
      t.string  :driving_license_number,    null: false
      t.date    :expiring_date,             null: false
      t.boolean :working,                   null: false, default: false
      t.timestamps
    end

    add_index :drivers, :email,                   unique: true
    add_index :drivers, :driving_license_number,  unique: true
  end
end
