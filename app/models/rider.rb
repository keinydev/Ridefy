# models/rider.rb

class Rider < ActiveRecord::Base
  validates :first_name, :last_name, :phone, :email, presence: true
  validates :email, uniqueness: true

  has_many :trips
  has_many :payment_methods

  scope :rider_authorized, -> (email) do
    joins(:payment_methods).where("(riders.email = :email AND payment_methods.source_id != '' AND payment_methods.token != '')", email: email)
  end  
end
