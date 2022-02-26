require "test_helper"

class BookingTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "create a first checkin mission when created" do
    listing = listings(:small_condo)

  test "create a last checkout mission when created" do
    assert_difference '@listing.missions.last_checkout.count' do
      booking = @listing.bookings.create(
        start_date: '2022-02-27',
        end_date: '2022-02-28'
      )
    end
  end
end
