class Mission < ApplicationRecord
  include MissionFactory

  enum mission_type: {
    first_checkin: 'first_checkin',
    last_checkout: 'last_checkout',
    checkout_checkin: 'checkout_checkin',
  }

  belongs_to :listing

  validates :mission_type, uniqueness: { scope: [:listing_id, :date] }
end
