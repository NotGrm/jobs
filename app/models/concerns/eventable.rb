module Eventable
  extend ActiveSupport::Concern

  included do
    before_destroy :prevent_destroy_if_started
  end

  private

  def prevent_destroy_if_started
    return if start_date > Date.current

    errors.add(:start_date, "#{model_name.name} is already started")
    throw :abort
  end
end
