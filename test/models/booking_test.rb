require "test_helper"

class BookingTest < ActiveSupport::TestCase
  setup do
    @listing = listings(:small_condo)
  end

  test "create a first checkin mission when created" do
    assert_difference '@listing.missions.first_checkin.count' do
      @listing.bookings.create(
        start_date: '2022-02-27',
        end_date: '2022-02-28'
      )
    end
  end

  test "create a last checkout mission when created" do
    assert_difference '@listing.missions.last_checkout.count' do
      @listing.bookings.create(
        start_date: '2022-02-27',
        end_date: '2022-02-28'
      )
    end
  end

  test "prevent destroy if booking start date is reached" do
    booking = bookings(:one)

    travel_to booking.start_date

    assert_no_difference 'Booking.count' do
      booking.destroy
    end
  end

  test "remove first checkin when destroyed" do
    booking = bookings(:one)

    travel_to 1.day.before(booking.start_date)

    assert_difference '@listing.missions.first_checkin.count', -1 do
      booking.destroy
    end
  end

  test "remove last checkout when destroyed" do
    booking = bookings(:one)

    travel_to 1.day.before(booking.start_date)

    assert_difference '@listing.missions.last_checkout.count', -1 do
      booking.destroy
    end
  end

  test "remove reservation happening during the booking period" do
    booking = bookings(:one)

    travel_to 1.day.before(booking.start_date)

    assert_difference '@listing.reservations.count', -2 do
      booking.destroy
    end
  end
end
