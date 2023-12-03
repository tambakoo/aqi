class CitiesController < ApplicationController

  before_action :find_city, except: [:index]

  def index
    @cities = City.all
  end

  def average_monthly_aqi
    @average_aqi_hash = @city.average_monthly_aqi
  end

  private

  def find_city
    @city = City.find_by(id: params[:city_id] || params[:id])
  end

end
