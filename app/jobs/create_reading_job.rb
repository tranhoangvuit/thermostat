class CreateReadingJob < ApplicationJob

  queue_as :default

  attr_reader :reading

  after_perform :update_reading_in_cache

  def perform(reading_params)
    @reading = Reading.new(reading_params)
    @reading.save!
  end

  private

  def update_reading_in_cache
    readings = Rails.cache.read("readings")
    idx = readings.index { |read| read.tracking_number == @reading.tracking_number }
    readings.delete_at(idx) unless idx.nil?
    Rails.cache.write("readings", readings)
  end

end