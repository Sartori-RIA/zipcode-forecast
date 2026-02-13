# ZipCode Forecast


### Requirements:

- Ruby: 4.0.1
- Rails: 8.1.2

### Project Setup

- Create your Free API KEY on [OpenWeather](https://home.openweathermap.org/api_keys)
- Run `cp example.env .env`
- Add your API KEY on `OPEN_WEATHER_API_KEY`
- Run `rails s`
- Open your browser on `http:localhost:3000`

### Decisions

Using the [OpenWeather](https://openweathermap.org/api/one-call-3?collection=one_call_api_3.0) to take the weather forecast
with this library was possible take the weather forecast and geolocation data from the ZipCode

Added the gem [VCR](https://benoittgt.github.io/vcr/#/test_frameworks/rspec_metadata) to reuse responses from OpenWeather in the specs
so doesn't reach the API Limit

Added flash message to invalid zipcode