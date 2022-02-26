module API
  class MissionsController < ApplicationController
    # GET /missions
    def index
      @missions = Mission.all

      render :index
    end
  end
end
