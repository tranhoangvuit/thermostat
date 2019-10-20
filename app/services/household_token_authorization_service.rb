class HouseholdTokenAuthorizationService
  
  class InvalidHouseholdToken < StandardError; end

  attr_reader :household_token, :thermostat

  def initialize(household_token)
    @household_token = household_token
  end

  def call
    # I just use standard parameter instead of household token
    raise InvalidHouseholdToken, 'Authorization is blank' if @household_token.blank?

    raise InvalidHouseholdToken, 'Authorization does not exist' if thermostat.blank? 
    true
  end

  def thermostat
    @thermostat ||= Thermostat.find_by(household_token: @household_token)
  end

end