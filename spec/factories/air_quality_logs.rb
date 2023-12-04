FactoryBot.define do
  factory :air_quality_log do
    concentrations { {"co": 1762.39, "no": 0, "o3": 20.03, "nh3": 33.44, "no2": 59.63, "so2": 120.16, "pm10": 348.19, "pm2_5": 310.79} }
    recorded_on { Time.zone.now}
    index { (1..5).to_a.sample }
  end
end
