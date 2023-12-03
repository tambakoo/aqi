namespace :update_data do
  desc "Fetch fresh data from open weather API for all cities"
  task aqi: :environment do
    City.all.each do |city|
      FetchAndUpdateAqiDataJob.perform_async(city.id)
    end
  end

end
