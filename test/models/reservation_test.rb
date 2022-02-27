require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  include ActiveSupport::Testing::TimeHelpers

  setup do
    @listing = listings(:small_condo)
  end

  test "create a checkout checkin mission when created" do
    assert_difference '@listing.missions.checkout_checkin.count' do
      @listing.reservations.create(
        start_date: '2022-03-03',
        end_date: '2022-03-04'
      )
    end
  end

  test "do not create a checkout checkin mission when created and a last checkout is planned" do
    Mission.last_checkout.create(date: '2022-03-02', listing: @listing)

    assert_no_difference '@listing.missions.checkout_checkin.count' do
      @listing.reservations.create(
        start_date: '2022-03-01',
        end_date: '2022-03-02'
      )
    end
  end

  test "prevent destroy if reservation start date is reached" do
    reservation = reservations(:one)

    travel_to reservation.start_date

    assert_no_difference 'Reservation.count' do
      reservation.destroy
    end
  end

  test "remove checkout checkin when destroyed" do
    reservation = reservations(:one)

    travel_to 1.day.before(reservation.start_date)

    assert_difference '@listing.missions.checkout_checkin.count', -1 do
      reservation.destroy
    end
  end

  test "do nothing when destroyed and no checkout checkin is planned" do
    reservation = reservations(:two)

    travel_to 1.day.before(reservation.start_date)

    assert_no_difference '@listing.missions.checkout_checkin.count' do
      reservation.destroy
    end
  end
end
