require "test_helper"

class CreateFirstCheckinMissionJobTest < ActiveJob::TestCase
  setup do
    @booking = bookings(:one)
  end

  test "create a mission" do
    assert_difference 'Mission.count' do
      CreateFirstCheckinMissionJob.perform_now(@booking)
    end

  end

  test "sets the mission attributes" do
    mission = CreateFirstCheckinMissionJob.perform_now(@booking)

    assert_predicate mission, :first_checkin?
    assert_equal mission.date, @booking.start_date
    assert_equal mission.listing, @booking.listing
  end
end
