module WeatherService
  module Base
    class WeatherSummary
      attr_reader :address, :forecasts, :created_at, :from_cache

      def initialize(address:, forecasts:, from_cache:, created_at: Time.zone.now)
        @address = address
        @forecasts = forecasts
        @created_at = created_at
        @from_cache = from_cache
      end
    end
  end
end
