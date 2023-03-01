module LocationService
  class Service
    def initialize(client = LocationService::Radar::Client.new)
      @client = client
    end

    def locate(address:)
      @client.locate(address:)
    end
  end
end
