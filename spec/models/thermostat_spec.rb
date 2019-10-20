require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  subject { build(:thermostat) }

  it { is_expected.to have_many(:readings).inverse_of(:thermostat) }
end
