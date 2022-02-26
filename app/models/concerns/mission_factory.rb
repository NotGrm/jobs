module MissionFactory
  extend ActiveSupport::Concern

  class_methods do
    def create_first_checkin_for(booking)
      self.first_checkin.create(
        date: booking.start_date,
        listing: booking.listing
      )
    end

    def create_last_checkout_for(booking)
      self.last_checkout.create(
        date: booking.end_date,
        listing: booking.listing
      )
    end

    def create_checkout_checkin_for(reservation)
      self.checkout_checkin.create(
        date: reservation.end_date,
        listing: reservation.listing
      )
    end
  end
end
