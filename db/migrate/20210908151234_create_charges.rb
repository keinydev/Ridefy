class CreateCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :charges do |t|
      t.float      :total,           null: false, default: 0.0
      t.belongs_to :trip,            null: false, index: true, foreign_key: true
      t.belongs_to :payment_method,  index: true, foreign_key: true
      t.string     :transaction_id   
      t.timestamps
    end
  end
end
