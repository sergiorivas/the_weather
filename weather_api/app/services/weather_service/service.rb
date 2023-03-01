module WeatherService
  class Service
    def initialize(client: WeatherService::WeatherGov::Client.new, location_service: LocationService::Service.new)
      @client = client
      @location_service = location_service
    end

    def forecast(address_query:)
      address = @location_service.locate(address_query:)
      forecasts = @client.forecast(latitude: address.latitude, longitude: address.longitude)
      WeatherService::Base::WeatherSummary.new(
        address:,
        forecasts:,
        from_cache: false
      )
    end
  end
end
