require "test_helper"

class DestroyCheckoutCheckinMissionJobTest < ActiveJob::TestCase
  setup do
    @reservation_with_checkout_checkin = reservations(:one)
    @reservation_without_checkout_checkin = reservations(:two)
  end

  test "destroy the mission when planned" do
    assert_difference 'Mission.count', -1 do
      DestroyCheckoutCheckinMissionJob.perform_now(@reservation_with_checkout_checkin)
    end
  end

  test "do nothing when nothing is planned" do
    assert_no_difference 'Mission.count' do
      DestroyCheckoutCheckinMissionJob.perform_now(@reservation_without_checkout_checkin)
    end
  end
end
