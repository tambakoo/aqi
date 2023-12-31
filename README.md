# README

## AQI app

Technology stack and tools
- Ruby v >= 2.7.6
- Rails v >= 7.1.2 
- Postgresql for database
- Redis
---
Implementation notes
1. **Data models**  
App has 2 data models - City (stores location data) and AirQualityLog (stores air quality data from open weather API)
2. **Open weather APIs**  
External API integration follow a service-object design pattern. Current data, historical data and location details are all seperate services, can be found under `app/services`
3. Initial data population is taken care in the seed file. It will create location records, fetch their co-ordinates from external API, fetch historic AQI data from external API all during setup.
4. The importer is implemented in the `FetchAqiService` and is called through the `FetchAndUpdateAqiDataJob` which is asynchronously run by sidekiq. For demo (sub 1 minute) and application rule that needs to re-run it every 1 hour a cron replication is done using `sidekiq-cron`. To change, set or reset the importer frequency refer [sidekiq-cron](https://github.com/sidekiq-cron/sidekiq-cron)
5. The app's UI has 3 screens -
- An index page that lists all locations and their respective data.
- A location show page that lists historic pollution data for a location.
- A monthly average page for a location which shows the monthly average AQI.
All the queries are covered in these pages.
6. Tests are implemented in Rspec.
---
Setup
1. Clone the repository and bundle.
2. Get the `master.key` and add it in the `app/config/master.key` file. Create the file if needed.
3. Create a database with `rails db:create`.
4. Switch on rails server with `rails s`. 
5. Turn on a redis server (or a daemon). 
6. Turn on sidekiq server with command `sidekiq`.
7. Seed the database using `rails db:seed`.
At this point, the app should greet you with an index page of locations on `localhost:300`. Further navigation is self explanatory. 
8. To manage the cron job that fetches AQI data from external API, alter the job with `Sidekiq::Cron::Job`. Refer [titsidekiq-cron](https://github.com/sidekiq-cron/sidekiq-cron) for commands.
---