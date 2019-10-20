require 'rails_helper'

RSpec.describe StatsService, type: :service do

  let(:thermostat) { create(:thermostat) }
  
  subject(:stats_service) { described_class.new(thermostat) }

  # context 'with a valid value' do
  #   let!(:reading1) { create(:reading, temperature: 25, humidity: 50, battery_charge: 50)}
  #   let(:result) do
  #     stats_service.call
  #   end

  #   it { byebug }
  #   it { expect(result[:avg_battery_charge]).to eq(25) }
  #   it { expect(result[:avg_humidity]).to eq(50) }
  #   it { expect(result[:avg_battery_charge]).to eq(50) }
  # end

  context 'with nothing in database' do
    let(:result) do
      stats_service.call
    end

    it { expect(result[:avg_battery_charge]).to eq(0) }
    it { expect(result[:max_battery_charge]).to eq(0) }
    it { expect(result[:min_battery_charge]).to eq(0) }
  end

end