module LocationService
  module Base
    class LocationInterface
      def locate(address:)
        raise NotImplementedError
      end
    end
  end
end
