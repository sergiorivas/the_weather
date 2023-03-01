module LocationService
  module Base
    class Address
      attr_reader :latitude, :longitude, :formal_address, :zipcode, :informal_address

      def initialize(latitude:, longitude:, formal_address:, zipcode:, informal_address:)
        @latitude = latitude
        @longitude = longitude
        @formal_address = formal_address
        @zipcode = zipcode
        @informal_address = informal_address
      end

      def self.sanitize(address:)
        address.split.map(&:strip).join(' ').upcase
      end
    end
  end
end
