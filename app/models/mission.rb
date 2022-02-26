class Mission < ApplicationRecord
  enum mission_type: {
    first_checkin: 'first_checkin',
    last_checkout: 'last_checkout',
    checkout_checkin: 'checkout_checkin',
  }

  belongs_to :listing

  validates :mission_type, uniqueness: { scope: [:listing_id, :date] }

  def self.create_first_checkin_for(booking)
    Mission.first_checkin.create(
      date: booking.start_date,
      listing: booking.listing
    )
  end
end
