class ReadingController < ApplicationController

  def index
    # This action can be in service if we have more feature, but at here just simple logic so I decide to put it in controller.
    readings = Rails.cache.read("readings")
    reading = readings.select { |read| read.tracking_number == reading_params[:tracking_number].to_i }.first
    if reading.nil?
      reading = Reading.find_by!(tracking_number: reading_params[:tracking_number])
    end
    render json: reading
  end

  def create
    @service = CreateReadingService.new(@current_thermostat, reading_new_params)
    if @service.call
      render json: { tracking_number: @service.tracking_number + 1 }
    else
      render json: { errors: @service.errors } 
    end
  end

  def reading_params
    params.permit(:tracking_number)
  end

  def reading_new_params
    params.permit(:temperature, :humidity, :battery_charge)
  end

end
