module WeatherService
  module Base
    class WeatherClientInterface
      def forecast(latitude:, longitude:)
        raise NotImplementedError
      end
    end
  end
end
