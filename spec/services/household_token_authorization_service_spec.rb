require 'rails_helper'

RSpec.describe HouseholdTokenAuthorizationService, type: :service do

  subject(:household_token_service) { described_class.new(params) }

  context 'with a valid household token' do
    let(:thermostat) { create(:thermostat) }
    let(:params) { thermostat.household_token }

    it { expect(household_token_service.call).to eq(true) }
  end

  # context 'with a invalid household token' do
  #   let(:params) { 'invalid household token' }

  #   it { expect(household_token_service.call).to raise_error (HouseholdTokenAuthorizationService::InvalidHouseholdToken) }
  # end

end