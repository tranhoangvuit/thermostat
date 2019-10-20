class CreateReadingService

  include ActiveModel::Model

  attr_accessor :thermostat, :temperature, :humidity, :battery_charge, :tracking_number

  def initialize(thermostat, params)
    @thermostat = thermostat
    super(params)
  end

  def call
    return false if invalid?
  
    update_readings_in_cache(reading_params)
    CreateReadingJob.perform_later(reading_params)
    Rails.cache.write('tracking_number',tracking_number + 1)
    true
  end

  def tracking_number
    temp_number = Rails.cache.read('tracking_number') || Reading.maximum(:tracking_number)
    @tracking_number ||= temp_number || 0
  end

  private

  def update_readings_in_cache(reading_params)
    readings = Rails.cache.read("readings")
    readings = [] if readings.nil?
    readings.push(Reading.new(reading_params))
    Rails.cache.write("readings", readings)
  end

  def reading_params
    {
      thermostat: @thermostat,
      temperature: @temperature,
      humidity: @humidity,
      battery_charge: @battery_charge,
      tracking_number: tracking_number + 1
    }
  end

end
