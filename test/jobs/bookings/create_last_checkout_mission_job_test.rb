require "test_helper"

class Bookings::CreateLastCheckoutMissionJobTest < ActiveJob::TestCase
  setup do
    @booking = bookings(:two)
  end

  test "create a mission" do
    assert_difference 'Mission.count' do
      Bookings::CreateLastCheckoutMissionJob.perform_now(@booking)
    end
  end

  test "sets the mission attributes" do
    mission = Bookings::CreateLastCheckoutMissionJob.perform_now(@booking)

    assert_predicate mission, :last_checkout?
    assert_equal mission.date, @booking.end_date
    assert_equal mission.listing, @booking.listing
  end
end
