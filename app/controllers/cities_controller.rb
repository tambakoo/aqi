class CitiesController < ApplicationController

  before_action :find_city, except: [:index]

  def index
    @cities = City.all
  end

  #Todo - have a 404 here
  def show
    @city = City.find_by(id: params[:id])
  end

  def average_monthly_aqi
    @average_aqi_hash = @city.average_monthly_aqi
  end


  private

  def find_city
    @city = City.find_by(id: params[:city_id])
  end

  def permitted_resource_params
    params.require(:city).permit(:id)
  end
end
