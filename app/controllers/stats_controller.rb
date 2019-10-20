class StatsController < ApplicationController

  def index
    @service = StatsService.new(@current_thermostat)
    result = @service.call
    render json: result
  end

end
