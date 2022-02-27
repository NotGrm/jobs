class CreateFirstCheckinMissionJob < ApplicationJob
  queue_as :default

  def perform(booking)
    mission = Mission.create_first_checkin_for(booking)
  end
end
