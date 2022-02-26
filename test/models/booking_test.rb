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
end
