class CreateLastCheckoutMissionJob < ApplicationJob
  queue_as :default

  def perform(booking)
    Mission.create_last_checkout_for(booking)
  end
end
