require 'rails_helper'

RSpec.describe Reading, type: :model do
  subject { build(:reading) }

  it { is_expected.to belong_to(:thermostat).inverse_of(:readings) }
end
