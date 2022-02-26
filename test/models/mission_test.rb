require "test_helper"

class MissionTest < ActiveSupport::TestCase
  test "set the right price for a first checkin in a small condo" do
    mission = Mission.new(mission_type: :first_checkin, listing: listings(:small_condo))
    mission.save
    assert_equal(10, mission.price)
  end

  test "set the right price for a first checkin in a big condo" do
    mission = Mission.new(mission_type: :first_checkin, listing: listings(:big_condo))
    mission.save
    assert_equal(20, mission.price)
  end

  test "set the right price for a checkout-checkin in a small condo" do
    mission = Mission.new(mission_type: :checkout_checkin, listing: listings(:small_condo))
    mission.save
    assert_equal(10, mission.price)
  end

  test "set the right price for a checkout-checkin in a big condo" do
    mission = Mission.new(mission_type: :checkout_checkin, listing: listings(:big_condo))
    mission.save
    assert_equal(20, mission.price)
  end

  test "set the right price for a last checkout in a small condo" do
    mission = Mission.new(mission_type: :last_checkout, listing: listings(:small_condo))
    mission.save
    assert_equal(5, mission.price)
  end

  test "set the right price for a last checkout in a big condo" do
    mission = Mission.new(mission_type: :last_checkout, listing: listings(:big_condo))
    mission.save
    assert_equal(10, mission.price)
  end
end
