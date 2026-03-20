# Represents a city tracked for air quality monitoring.
# Each city has geographic coordinates and is associated with historical AQI logs.
class City < ApplicationRecord

  # Air quality logs ordered most recent first
  has_many  :air_quality_logs, -> { order(recorded_on: :desc) }

  # Returns the city's latitude and longitude rounded to 2 decimal places
  def coordinates
    "#{latitude.round(2)}, #{longitude.round(2)}"
  end

  # Returns the most recent air quality log entry
  def latest_aqi
    air_quality_logs.first
  end

  # Returns the overall average AQI index across all logs, or "No data" if none exist
  def average_aqi_index
    if air_quality_logs.present?
      air_quality_logs.sum(:index)/air_quality_logs.count
    else
      "No data"
    end
  end

  # Returns a hash of average AQI per month, format: { "month/year" => avg_aqi }
  # Groups logs by month, computes the mean AQI index, and keys by "month/year"
  def average_monthly_aqi
    if air_quality_logs.present?
      logs = air_quality_logs.group_by { |m| m.recorded_on.month }
      average_hash = {}
      logs.each do |monthly_log|
        monthly_average = (monthly_log[1].map{|x| x.index}.sum).to_f/monthly_log[1].count
        year = monthly_log[1].sample.recorded_on.year
        average_hash["#{monthly_log[0]}/#{year}"] = monthly_average.round(2)
      end
      average_hash
    else
      "No data"
    end
  end

end
