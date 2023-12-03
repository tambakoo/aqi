class FetchAndUpdateCityDataJob
  include Sidekiq::Job

  def perform(city_id)
    city = City.find_by(id: city_id)
    serv_obj = FetchLocationDetailsService.new(city: city)
    if serv_obj.call.eql?(true)
      city_data = serv_obj.response_payload.first
      city.update latitude: city_data["lat"], longitude: city_data["lon"]
      puts "Fetched co-ordinates for #{city.name}"
    end
  end
end
