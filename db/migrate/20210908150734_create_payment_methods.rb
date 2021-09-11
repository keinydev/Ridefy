class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods  do |t|
      t.string     :method_type,   null: false, default: "CARD"
      t.string     :source_id,     null: false
      t.belongs_to :rider,         null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
