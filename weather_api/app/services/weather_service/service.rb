module WeatherService
  class Service
    def initialize(client: WeatherService::WeatherGov::Client.new, location_service: LocationService::Service.new)
      @client = client
      @location_service = location_service
    end

    def forecast(address_query:)
      address = @location_service.locate(address_query:)
      from_cache = Rails.cache.exist?(address.zipcode)
      forecasts = Rails.cache.fetch(address.zipcode, expires_in: 30.minutes) do
        @client.forecast(latitude: address.latitude, longitude: address.longitude)
      end
      WeatherService::Base::WeatherSummary.new(address:, forecasts:, from_cache:)
    end
  end
end
