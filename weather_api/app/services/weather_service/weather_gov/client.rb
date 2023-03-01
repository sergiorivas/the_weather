module WeatherService
  module WeatherGov
    class Client < WeatherService::Base::WeatherClientInterface
      def initialize
        @connection = Faraday.new(
          url: 'https://api.weather.gov',
          headers: {
            'Content-Type' => 'application/json'
          }
        )
      end

      def forecast(latitude:, longitude:)
        forecast_data = []
        response = request_forecast(latitude:, longitude:)
        Rails.logger.debug response
        wheather_data = JSON.parse(response)['properties']['periods']
        wheather_data.each do |weather_data_point|
          forecast_data << WeatherService::Base::WeatherDetail.new(
            temperature: weather_data_point['temperature'],
            temperature_unit: weather_data_point['temperatureUnit'],
            start_time: Time.rfc3339(weather_data_point['startTime']),
            end_time: Time.rfc3339(weather_data_point['endTime']),
            name: weather_data_point['name'],
            relative_humitidy: weather_data_point['relativeHumidity']['value'],
            wind_speed: weather_data_point['windSpeed'],
            wind_direction: weather_data_point['windDirection'],
            icon_url: weather_data_point['icon'],
            summary: weather_data_point['shortForecast'],
            forecast_description: weather_data_point['detailedForecast']
          )
        end
        forecast_data
      rescue StandardError
        raise 'Weather not available'
      end

      private

      def request_forecast(latitude:, longitude:)
        response = @connection.get("/points/#{latitude},#{longitude}").body
        forecast_url = JSON.parse(response)['properties']['forecast']
        Rails.logger.debug @connection.get(forecast_url).body
      end
    end
  end
end
