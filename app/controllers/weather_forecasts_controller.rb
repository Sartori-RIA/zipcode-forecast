# frozen_string_literal: true

require "net/http"
require "json"

class WeatherForecastsController < ApplicationController
  after_action -> { flash.discard }

  def index
    @zipcode = params[:zipcode]

    if @zipcode.present? && zipcode_valid?
      @geo, @forecast, @came_from_cache = forecast_service.call
    else @zipcode.present?
    flash[:error] = t("errors.zipcode.invalid")
    end

    if @geo.present? && %w[404 400].include?(@geo["cod"])
      flash[:error] = t("errors.zipcode.invalid")
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
