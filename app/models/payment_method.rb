# models/payment_method.rb

class PaymentMethod < ActiveRecord::Base
  validates :method_type, :token, :source_id, presence: true

  belongs_to :rider
  has_many :charges

  def user_max_targets
    errors.add(:targets, "You are allowed to create only 3 targets") if user.targets.count >= 3
  end
end
