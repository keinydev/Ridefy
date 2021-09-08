class CreateCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :charges do |t|
      t.decimal    :total,           null: false
      t.belongs_to :trip,            null: false, index: true, foreign_key: true
      t.belongs_to :payment_method,  null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
