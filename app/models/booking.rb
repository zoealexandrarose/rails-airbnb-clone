class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :product, dependent: :destroy
  validates :message, :start_date, :end_date, presence: true
end
