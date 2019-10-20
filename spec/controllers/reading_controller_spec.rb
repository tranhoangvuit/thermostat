require 'rails_helper'

RSpec.describe ReadingController, type: :controller do
  let(:thermostat) { create(:thermostat) }

  before do
    request.headers['Authorization'] = household_token 
    request.headers['Accept'] = 'application/json'
    post :create, params: { data: { attributes: params } }
  end

  context 'with valid household token' do
    let(:household_token) { thermostat.household_token }
    describe 'POST #create' do
      let(:params) { { temperature: 23, humidity: 50, battery_charge: 90 } }

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body)['tracking_number']).to be >= 0 }
    end
  end

  context 'with valid household token and empty value' do
    let(:household_token) { thermostat.household_token }
    describe 'POST #create' do
      let(:params) { { } }

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body)['tracking_number']).to be >= 0 }
    end
  end

  context 'with invalid household token' do
    let(:household_token) { 'invalid token' }

    describe 'POST #create' do
      let(:params) { { temperature: 23, humidity: 50, battery_charge: 90 } }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
