require "test_helper"

class Bookings::CreateFirstCheckinMissionJobTest < ActiveJob::TestCase
  setup do
    @booking = bookings(:two)
  end

  test "create a mission" do
    assert_difference 'Mission.count' do
      Bookings::CreateFirstCheckinMissionJob.perform_now(@booking)
    end

  end

  test "sets the mission attributes" do
    mission = Bookings::CreateFirstCheckinMissionJob.perform_now(@booking)

    assert_predicate mission, :first_checkin?
    assert_equal mission.date, @booking.start_date
    assert_equal mission.listing, @booking.listing
  end
end
