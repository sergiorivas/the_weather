module LocationService
  module Base
    class LocationClientInterface
      def locate(address:)
        raise NotImplementedError
      end
    end
  end
end
