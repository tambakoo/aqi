# frozen_string_literal: true

class FetchHistoricAqiService < BaseService

  attr_accessor :city, :start_time, :end_time, :success, :response_payload, :error_message

  require 'httparty'

  def initialize(params)
    super
    self.city = params[:city]
    self.start_time = params[:start_time]
    self.end_time = params[:end_time]
  end

  def call
    api_host = "http://api.openweathermap.org/data/2.5/air_pollution/history?"
    city_data = "lat=#{city.latitude}&lon=#{city.longitude}&start=#{start_time}&end=#{end_time}&appid=#{open_weather_api_key}"
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
