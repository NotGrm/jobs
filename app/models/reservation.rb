class Reservation < ApplicationRecord
  belongs_to :listing

  def self.import(reservation_attributes)
    Reservation.insert_all reservation_attributes
  end
end
