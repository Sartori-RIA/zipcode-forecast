# ZipCode Forecast


### Requirements:

- Ruby: 4.0.1
- Rails: 8.1.2

### Project Setup

- Create your Free API KEY on [OpenWeather](https://home.openweathermap.org/api_keys)
- Run `cp example.env .env`
- Add your API KEY on `OPEN_WEATHER_API_KEY`
- Run `rails s`

### Decisions

Using the [OpenWeather](https://openweathermap.org/api/one-call-3?collection=one_call_api_3.0) to take the weather forecast
with this library was possible take the weather forecast and geolocation data from the ZipCode