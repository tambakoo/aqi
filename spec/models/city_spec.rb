# spec/models/city_spec.rb

require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'coordinates' do
    it 'returns formatted coordinates' do
      lat = rand(20.0..40).round(2)
      long = rand(20.0..40).round(2)
      coordinates = "#{lat}, #{long}"
      city = FactoryBot.create(:city, latitude: lat, longitude: long)
      expect(city.coordinates).to eq(coordinates)
    end
  end

  describe 'latest_aqi' do
    it 'returns the latest air quality log' do
      city = FactoryBot.create(:city)
      latest_log = FactoryBot.create(:air_quality_log, city: city, recorded_on: Date.today)
      expect(city.latest_aqi).to eq(latest_log)
    end
  end

  describe 'average_aqi_index' do
    context 'when air quality logs are present' do
      it 'returns the average AQI index' do
        city = FactoryBot.create(:city)
        create_list(:air_quality_log, 3, city: city, index: 10)
        expect(city.average_aqi_index).to eq(10)
      end
    end

    context 'when no air quality logs are present' do
      it 'returns "No data"' do
        city = FactoryBot.create(:city)
        expect(city.average_aqi_index).to eq('No data')
      end
    end
  end

  describe 'average_monthly_aqi' do
    context 'when air quality logs are present' do
      it 'returns a hash of monthly averages' do
        city = FactoryBot.create(:city)
        create(:air_quality_log, city: city, recorded_on: Date.new(2023, 1, 1), index: 30)
        create(:air_quality_log, city: city, recorded_on: Date.new(2023, 1, 15), index: 40)
        create(:air_quality_log, city: city, recorded_on: Date.new(2023, 2, 1), index: 20)

        average = { '1/2023' => 35.0, '2/2023' => 20.0 }
        expect(city.average_monthly_aqi).to eq(average)
      end
    end

    context 'when no air quality logs are present' do
      it 'returns "No data"' do
        city = FactoryBot.create(:city)
        expect(city.average_monthly_aqi).to eq('No data')
      end
    end
  end
end

