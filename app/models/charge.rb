# models/charge.rb

class Charge < ActiveRecord::Base
  validates :total, presence: true

  belongs_to :trip
  belongs_to :payment_method, optional: true
end
