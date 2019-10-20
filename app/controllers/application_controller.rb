class ApplicationController < ActionController::API

  attr_reader :current_thermostat

  before_action :authorize_household_token!

  rescue_from HouseholdTokenAuthorizationService::InvalidHouseholdToken, with: :invalid_household_token
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def authorize_household_token!
    service = HouseholdTokenAuthorizationService.new(request.headers['Authorization'])
    return unless service.call

    @current_thermostat = service.thermostat
  end

  def invalid_household_token(error)
    render json: { errors: [ message: error.message ] }, status: :unauthorized
  end

  def record_not_found(error)
    render json: { error: { message: error.message } }, status: :not_found
  end

end
