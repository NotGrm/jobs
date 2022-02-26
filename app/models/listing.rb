class Listing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :missions, dependent: :destroy
  has_many :reservations, dependent: :destroy

  def self.import(listing_attributes)
    Listing.insert_all listing_attributes
  end
end
