class StatsService

  def initialize(thermostat)
    @thermostat = thermostat
  end

  def call
    reading = get_reading_report
    {
      avg_temperature: (reading[:sum_temperature]/reading[:count]).round(2),
      avg_humidity: (reading[:sum_humidity]/reading[:count]).round(2),
      avg_battery_charge: (reading[:sum_battery_charge]/reading[:count]).round(2),
      max_temperature: reading[:max_temperature],
      max_humidity: reading[:max_humidity],
      max_battery_charge: reading[:max_battery_charge],
      min_temperature: reading[:min_temperature],
      min_humidity: reading[:min_humidity],
      min_battery_charge: reading[:min_battery_charge],
    } 
  end

  private

  def calculate_stats_from_db
    result = Reading.where(thermostat: @thermostat).pluck(Arel.sql('SUM(temperature)'), Arel.sql('SUM(humidity)'), Arel.sql('SUM(battery_charge)'), Arel.sql('MAX(temperature)'), Arel.sql('MAX(humidity)'), Arel.sql('MAX(battery_charge)'), Arel.sql('MIN(temperature)'), Arel.sql('MIN(humidity)'), Arel.sql('MIN(battery_charge)'), Arel.sql('count(tracking_number)')).first
    format_stats(result)
  end

  def get_reading_report
    reading_db = calculate_stats_from_db
    readings = Rails.cache.read("readings")
    return reading_db if readings.nil?
    readings.each do |reading|
      reading_db[:sum_temperature] += reading.temperature
      reading_db[:sum_humidity] += reading.humidity
      reading_db[:sum_battery_charge] += reading.battery_charge
      reading_db[:max_temperature] = reading.temperature if reading.temperature > reading_db[:max_temperature]
      reading_db[:max_humidity] = reading.humidity if reading.humidity > reading_db[:max_humidity]
      reading_db[:max_battery_charge] = reading.battery_charge if reading.battery_charge > reading_db[:max_battery_charge]
      reading_db[:min_temperature] = reading.temperature if reading.temperature < reading_db[:min_temperature]
      reading_db[:min_humidity] = reading.humidity if reading.humidity < reading_db[:min_humidity]
      reading_db[:min_battery_charge] = reading.battery_charge if reading.battery_charge < reading_db[:min_battery_charge]
      reading_db[:count] += 1
    end
    reading_db
  end

  def format_stats(result)
    {
      sum_temperature: result[0] || 0,
      sum_humidity: result[1] || 0,
      sum_battery_charge: result[2] || 0,
      max_temperature: result[3] || 0,
      max_humidity: result[4] || 0,
      max_battery_charge: result[5] || 0,
      min_temperature: result[6] || 0,
      min_humidity: result[7] || 0,
      min_battery_charge: result[8] || 0,
      count: result[9] > 0? result[9] : 1,
    }
  end

end