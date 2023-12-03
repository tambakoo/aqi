class AirQualityLog < ApplicationRecord
  belongs_to :city

  def pollutants_data
    dat = ""
    concentrations.each_with_index do |gas, ind|
      comma = ind < concentrations.count - 1 ? ",": ""
      dat = "#{dat}#{gas[0].capitalize}: #{gas[1]}#{comma} "
    end
    dat
  end
end
