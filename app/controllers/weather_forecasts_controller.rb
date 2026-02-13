# frozen_string_literal: true

require 'net/http'
require 'json'

class WeatherForecastsController < ApplicationController
  def index
    @zipcode = params[:zipcode]

    if zipcode_valid?
      @geo, @forecast, @came_from_cache = forecast_service.call
    end
  end

  private

  def zipcode_valid?
    @zipcode&.match?(/^\d{5}$/)
  end

  def forecast_service
    @forecast_service = ::WeatherForecastService.new(zipcode: @zipcode)
  end
end
