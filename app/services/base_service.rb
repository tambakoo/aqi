# frozen_string_literal: true

class BaseService

  def initialize(params)
    @success = true
  end

  private

  def intercept_response(response)
    if response.code.eql?(200)
      @response_payload = response
    else
      @success = false
      @error_message = response["message"]
    end
  end

  def open_weather_api_key
    Rails.application.credentials.weather_api_key
  end

end