namespace :update_data do
  desc "Fetch fresh data from open weather API for all cities"
  task aqi: :environment do
    FetchAndUpdateAqiDataJob.perform_async
  end

  desc "Fetch historical annual AQI data from open weather API for all cities"
  task annual_aqi: :environment do
    City.all.each do |city|
      start_date = Date.today - 1.year
      12.times do
        start_time = start_date.to_datetime.to_i
        end_time = (start_date + 30).to_datetime.to_i
        FetchAndUpdateHistoricAqiDataJob.perform_async(city.id, start_time, end_time)
        start_date = start_date + 1.month
      end 
    end
  end

end
