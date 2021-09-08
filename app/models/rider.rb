# models/rider.rb

class Rider < ActiveRecord::Base
  validates :first_name, :last_name, :phone, :email, presence: true
  validates :email, uniqueness: true

  has_many :trips
  has_many :payment_methods
end
