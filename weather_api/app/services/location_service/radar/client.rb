module LocationService
  module Radar
    class Client < LocationService::Base::LocationInterface
      def initialize
        @connection = Faraday.new(
          url: 'https://api.radar.io',
          params: { param: '1' },
          headers: {
            'Content-Type' => 'application/json',
            'Authorization' => ENV.fetch('RADAR_SECRET_KEY', nil)
          }
        )
      end

      def locate(address:)
        response = request_address(address:)
        address_data = JSON.parse(response)['addresses'].first
        LocationService::Base::Address.new(
          latitude: address_data['latitude'],
          longitude: address_data['longitude'],
          zipcode: address_data['postalCode'],
          informal_address: "#{address_data['countryFlag']} #{address_data['neighborhood']}, #{address_data['city']}, #{address_data['state']}, #{address_data['country']}",
          formal_address: address_data['formattedAddress']
        )
      rescue StandardError
        raise 'Address not available'
      end

      private

      def request_address(address:)
        @connection.get("/v1/geocode/forward?query=#{address}").body
      end
    end
  end
end
