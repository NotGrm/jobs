class Mission < ApplicationRecord
  include MissionFactory

  enum mission_type: {
    first_checkin: 'first_checkin',
    last_checkout: 'last_checkout',
    checkout_checkin: 'checkout_checkin',
  }

  belongs_to :listing

  validates :mission_type, uniqueness: { scope: [:listing_id, :date] }

  before_create :set_price

  delegate :number_of_rooms, to: :listing
  delegate :price_per_room, to: :cleaning_task

  private

  def set_price
    self[:price] = number_of_rooms * price_per_room
  end

  def cleaning_task
    @cleaning_task ||= "CleaningTask::#{mission_type.classify}".constantize.new
  end
end
