class City < ApplicationRecord

  has_many  :air_quality_logs, -> { order(recorded_on: :desc) }

  def coordinates
    "#{latitude.round(2)}, #{longitude.round(2)}"
  end

  def latest_aqi
    air_quality_logs.first
  end

  def average_aqi_index
    if air_quality_logs.present?
      air_quality_logs.sum(:index)/air_quality_logs.count
    else
      "No data"
    end
  end

  def average_monthly_aqi #returns a hash of format key = month/year, value = aqi
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
