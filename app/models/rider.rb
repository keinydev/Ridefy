# models/rider.rb

class Rider < ActiveRecord::Base
  validates :first_name, :last_name, :phone, :email, presence: true
  validates :email, uniqueness: true

  has_many :trips
  has_many :payment_methods

  scope :rider_ongoing, -> (email) do
    joins(:trips).where("(riders.email = :email AND trips.end_time IS NULL)", email: email)
  end  

  scope :rider_authorized, -> (email) do
    joins(:payment_methods).where("(riders.email = :email AND payment_methods.source_id != '')", email: email)
  end  

  scope :rider_payment_method, -> (email, payment_method_id) do
    joins(:payment_methods, :trips).where("(riders.email = :email AND payment_methods.id = :payment_method_id)", email: email, payment_method_id: payment_method_id)
  end  
end
