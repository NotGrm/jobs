require "test_helper"

class CreateCheckoutCheckinMissionJobTest < ActiveJob::TestCase
  setup do
    @reservation = reservations(:three)
  end

  test "create a mission" do
    assert_difference 'Mission.count' do
      CreateCheckoutCheckinMissionJob.perform_now(@reservation)
    end
  end

  test "sets the mission attributes" do
    mission = CreateCheckoutCheckinMissionJob.perform_now(@reservation)

    assert_predicate mission, :checkout_checkin?
    assert_equal mission.date, @reservation.end_date
    assert_equal mission.listing, @reservation.listing
  end

  test "do nothing when a last checkout is planned at the same date" do
    Mission.last_checkout.create(date: @reservation.end_date, listing: @reservation.listing)

    assert_no_difference 'Mission.count' do
      CreateCheckoutCheckinMissionJob.perform_now(@reservation)
    end
  end
end
