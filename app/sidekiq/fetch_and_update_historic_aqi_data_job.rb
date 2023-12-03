class FetchAndUpdateHistoricAqiDataJob
  include Sidekiq::Job

  def perform(city_id, start_time, end_time)
    city = City.find_by(id: city_id)
    serv_obj = FetchHistoricAqiService.new(city: city, start_time: start_time, end_time: end_time)
    if serv_obj.call.eql?(true)
      aqi_data = serv_obj.response_payload["list"].sample(30)
      aqi_data.each do |aqi|
        city.air_quality_logs.create index: aqi["main"]["aqi"], concentrations: aqi["components"], recorded_on: Time.at(aqi["dt"]).to_datetime  
      end
      starting = Time.at(start_time).strftime("%d-%b-%y %H:%M %Z")
      ending = Time.at(end_time).strftime("%d-%b-%y %H:%M %Z")
      puts "Fetched historic data for #{city.name} from #{starting} to #{ending}"
    end
  end
end
