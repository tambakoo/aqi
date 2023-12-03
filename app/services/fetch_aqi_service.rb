# frozen_string_literal: true

class FetchAqiService < BaseService

  attr_accessor :city, :success, :response_payload, :error_message

  require 'httparty'

  def initialize(params)
    super
    self.city = params[:city]
  end

  def call
    api_host = "http://api.openweathermap.org/data/2.5/air_pollution?"
    city_data = "lat=#{city.latitude}&lon=#{city.longitude}&appid=#{open_weather_api_key}"
    begin
      response = HTTParty.get("#{api_host}#{city_data}")
    rescue => e
      @success = false
      #log error on error logging tool in production
    end
    intercept_response(response)
    @success
  end

end