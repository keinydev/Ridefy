class CreateRiders < ActiveRecord::Migration[6.1]
  def change
    create_table :riders do |t|
      t.string :first_name,    null: false
      t.string :last_name,     null: false
      t.string :email,         null: false
      t.string :phone,         null: false
      t.timestamps
    end

    add_index :riders, :email, unique: true
  end
end
