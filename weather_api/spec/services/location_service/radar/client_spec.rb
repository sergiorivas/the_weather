require 'rails_helper'

RSpec.describe LocationService::Radar::Client do
  subject { described_class.new }

  context 'when a address is available' do
    before do
      allow(subject).to receive(:request_address).and_return(%(
          {
            "addresses": [
              {
                "latitude": 1.0,
                "longitude": 2.0,
                "postalCode": "11111",
                "countryFlag": "FLAG",
                "neighborhood": "Kendall",
                "city": "Miami",
                "state": "Florida",
                "country": "United States",
                "formattedAddress": "This is an Address"
              }
            ]
          }
        ))
    end

    it 'creates an address' do
      expect(subject.locate(address: 'This is an Address').to_json).to eql(
        LocationService::Base::Address.new(
          latitude: 1.0,
          longitude: 2.0,
          zipcode: '11111',
          informal_address: 'FLAG Kendall, Miami, Florida, United States',
          formal_address: 'This is an Address'
        ).to_json
      )
    end
  end

  context 'when there is not connection to the API' do
    before do
      allow(subject).to receive(:request_address).and_raise
    end

    it 'raise an error' do
      expect { subject.locate(address: 'This is an Address') }.to raise_error
    end
  end
end
