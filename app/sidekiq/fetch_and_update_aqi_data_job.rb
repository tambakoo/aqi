class FetchAndUpdateAqiDataJob
  include Sidekiq::Job

  def perform
    City.all.each do |city|
      serv_obj = FetchAqiService.new(city: city)
      if serv_obj.call.eql?(true)
        aqi_data = serv_obj.response_payload["list"].first
        city.air_quality_logs.create index: aqi_data["main"]["aqi"], concentrations: aqi_data["components"], recorded_on: Time.at(aqi_data["dt"]).to_datetime
      end
    end
  end
end
