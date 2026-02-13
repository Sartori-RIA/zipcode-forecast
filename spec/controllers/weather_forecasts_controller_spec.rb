# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherForecastsController, type: :controller do
  let(:austin_zipcode) { "73301" }

  describe "#GET /index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "Error message to invalid zipcode" do
      get :index, params: { zipcode: 'potato' }
      expect(flash[:error]).to eq(I18n.t('errors.zipcode.invalid'))
    end

    vrc_options = { cassette_name: "open_weather_forecasts#index" }
    describe "Render weather forecast card", vcr: vrc_options do
      it "check weather forecast instance variables" do
        get :index, params: { zipcode: austin_zipcode }
        expect(@controller.instance_variable_get(:@forecast)).not_to be_nil
      end

      it "check geolocation instance variable" do
        get :index, params: { zipcode: austin_zipcode }
        expect(subject.instance_variable_get(:@geo)).not_to be_nil
      end

      it "check geolocation values" do
        get :index, params: { zipcode: austin_zipcode }
        geo = subject.instance_variable_get(:@geo)
        expect(geo["name"]).to eq("Austin")
        expect(geo["country"]).to eq("US")
        expect(geo["lat"]).to_not be_nil
        expect(geo["lon"]).to_not be_nil
        expect(geo["zip"]).to eq(austin_zipcode)
      end

      it "check weather forecast card details" do
        get :index, params: { zipcode: austin_zipcode }
        weather_forecast = @controller.instance_variable_get(:@forecast)
        expect(weather_forecast.keys).to eq(%w[coord weather base main visibility wind clouds dt sys timezone id name cod])
      end
    end
  end
end
