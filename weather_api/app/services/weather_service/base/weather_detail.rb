module WeatherService
  module Base
    class WeatherDetail
      attr_reader :temperature, :temperature_unit, :start_time, :end_time, :name, :relative_humitidy, :wind_speed,
                  :wind_direction, :icon_url, :summary, :forecast_description

      def initialize(temperature:, temperature_unit:, name:, forecast_description:, start_time: nil, end_time: nil, relative_humitidy: nil,
                     wind_speed: nil, wind_direction: nil, icon_url: nil, summary: nil)
        @temperature = temperature
        @temperature_unit = temperature_unit
        @start_time = start_time
        @end_time = end_time
        @name = name
        @relative_humitidy = relative_humitidy
        @wind_speed = wind_speed
        @wind_direction = wind_direction
        @icon_url = icon_url
        @summary = summary
        @forecast_description = forecast_description
      end
    end
  end
end
