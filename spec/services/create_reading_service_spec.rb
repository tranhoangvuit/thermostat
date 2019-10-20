require 'rails_helper'

RSpec.describe CreateReadingService, type: :service do

  let(:thermostat) { create(:thermostat) }
  subject(:reading_service) { described_class.new(thermostat, params) }

  context 'with a valid parameter' do
    let(:params) { { temperature: 23, humidity: 50, battery_charge: 90 } }

    it { expect(reading_service.call).to eq(true) }
  end

end