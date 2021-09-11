# models/payment_method.rb

class PaymentMethod < ActiveRecord::Base
  validates :method_type, :source_id, presence: true

  belongs_to :rider
  has_many :charges
end
