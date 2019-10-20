require 'rails_helper'

RSpec.describe StatsController, type: :controller do

  let(:thermostat) { create(:thermostat) }

  before do
    request.headers['Authorization'] = household_token 
    request.headers['Accept'] = 'application/json'
  end

  describe 'GET #index' do

    before { get :index }

    context 'with valid params' do
      let(:household_token) { thermostat.household_token }
      let!(:reading) { create(:reading, tracking_number: 12345, temperature: 25) }

      it { expect(response).to have_http_status(:ok) }
    end

    context 'with valid household token' do
      let(:household_token) { 'invalid token' }

      it { expect(response).to have_http_status(:unauthorized) }
    end

  end

end
