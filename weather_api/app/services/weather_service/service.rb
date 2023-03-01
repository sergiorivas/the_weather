module WeatherService
  class Service
    def initialize(client: WeatherService::WeatherGov::Client.new, location_service: LocationService::Service.new)
      @client = client
      @location_service = location_service
    end

    def forecast(address_query:)
      address = @location_service.locate(address_query:)
      cache_key = address.zipcode || address.formal_address
      from_cache = Rails.cache.exist?(cache_key)
      forecasts = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
        @client.forecast(latitude: address.latitude, longitude: address.longitude)
      end
      WeatherService::Base::WeatherSummary.new(address:, forecasts:, from_cache:)
    end
  end
end
