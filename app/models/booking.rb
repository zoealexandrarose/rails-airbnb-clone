class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :product, dependent: :destroy
  validates :message, presence: true
end
