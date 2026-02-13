class WeatherForecastService
  BASE_URL = "https://api.openweathermap.org"

  def initialize(zipcode:, country: "US")
    @zipcode = zipcode
    @country = country
    @api_key = ENV['OPEN_WEATHER_API_KEY']
  end

  def call
    came_from_cache = Rails.cache.exist?(weather_cache_key)
    geo, weather = geo_and_weather
    [ geo, weather, came_from_cache ]
  end

  private

  def geo_and_weather
    Rails.cache.fetch(weather_cache_key, expires_in: 30.minutes) do
      @geo = geo_data
      @weather_forecast = current_weather
      [ @geo, @weather_forecast ]
    end
  end

  def current_weather
    uri = URI("#{BASE_URL}/data/2.5/weather")
    uri.query = URI.encode_www_form(weather_params)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def geo_data
    uri = URI("#{BASE_URL}/geo/1.0/zip")
    uri.query = URI.encode_www_form(geo_params)

    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def geo_params
    {
      zip: "#{@zipcode},#{@country}",
      appid: @api_key
    }
  end

  def weather_params
    {
      lat: @geo["lat"],
      lon: @geo["lon"],
      appid: @api_key,
      units: "metric"
    }
  end

  def weather_cache_key
    "weather/#{@zipcode}/#{@country}"
  end
end
