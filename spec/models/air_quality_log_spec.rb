# spec/models/air_quality_log_spec.rb

require 'rails_helper'

RSpec.describe AirQualityLog, type: :model do
  describe '#pollutants_data' do
    it 'returns formatted pollutants data' do
      city = FactoryBot.create(:city)
      air_quality_log = create(:air_quality_log, city: city, concentrations: { 'co' => 1.5, 'no2' => 12.0, 'so2' => 4.5 })

      expect(air_quality_log.pollutants_data).to eq('Co: 1.5, No2: 12.0, So2: 4.5')
    end

    it 'handles empty concentrations' do
      city = create(:city)
      air_quality_log = create(:air_quality_log, city: city, concentrations: {})

      expect(air_quality_log.pollutants_data).to eq('')
    end
  end
end
