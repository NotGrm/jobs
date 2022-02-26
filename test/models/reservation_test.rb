require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  setup do
    @listing = listings(:small_condo)
  end

  test "create a checkout checkin mission when created" do
    assert_difference '@listing.missions.checkout_checkin.count' do
      @listing.reservations.create(
        start_date: '2022-02-27',
        end_date: '2022-02-28'
      )
    end
  end

  test "create a last checkout mission when created" do
    Mission.last_checkout.create(date: '2022-02-28', listing: @listing)

    assert_no_difference '@listing.missions.checkout_checkin.count' do
      @listing.reservations.create(
        start_date: '2022-02-27',
        end_date: '2022-02-28'
      )
    end
  end
end
