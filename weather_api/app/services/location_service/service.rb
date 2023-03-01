module LocationService
  class Service
    def initialize(client: LocationService::Radar::Client.new)
      @client = client
    end

    def locate(address_query:)
      sanitized_address_query = LocationService::Base::Address.sanitize(address: address_query)
      search = AddressSearch.find_by(query: sanitized_address_query)
      return search.address if search

      address = @client.locate(address: address_query)
      _db_address = save_address_and_query(
        query: sanitized_address_query,
        address:
      )
    end

    private

    def save_address_and_query(query:, address:)
      db_address = Address.find_by(formal_address: address.formal_address)
      ActiveRecord::Base.transaction do
        db_address ||= Address.create(
          latitude: address.latitude,
          longitude: address.longitude,
          formal_address: address.formal_address,
          zipcode: address.zipcode,
          informal_address: address.informal_address
        )

        AddressSearch.create(
          query:,
          address: db_address
        )
      end
      db_address
    end
  end
end
