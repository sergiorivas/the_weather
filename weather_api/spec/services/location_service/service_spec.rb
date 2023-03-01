require 'rails_helper'

RSpec.describe LocationService::Service do
  subject { described_class.new(client:) }

  let(:client) { LocationService::Radar::Client.new }

  before do
    allow(client).to receive(:locate) do
      LocationService::Base::Address.new(
        latitude: 1.0,
        longitude: 2.0,
        zipcode: '11111',
        informal_address: 'FLAG Kendall, Miami, Florida, United States',
        formal_address: 'This is an Address'
      )
    end
  end

  context 'when there is not address before' do
    it 'gets an address from client' do
      expect(client).to receive(:locate)
      subject.locate(address_query: 'This is an Address    ')
    end

    it 'saves the address and search' do
      expect do
        subject.locate(address_query: 'This is an Address    ')
      end.to change(Address, :count).by(1)
                                    .and change(AddressSearch, :count).by(1)
    end
  end

  context 'when there is an address before' do
    before do
      create(
        :address,
        latitude: 1.0,
        longitude: 2.0,
        zipcode: '11111',
        informal_address: 'FLAG Kendall, Miami, Florida, United States',
        formal_address: 'This is an Address'
      )
    end

    it 'uses the existent address and creates the search' do
      expect do
        subject.locate(address_query: 'This is an Address    ')
      end.to change(Address, :count).by(0)
                                    .and change(AddressSearch, :count).by(1)
    end
  end

  context 'when there is an similar query before' do
    before do
      address = create(
        :address,
        latitude: 1.0,
        longitude: 2.0,
        zipcode: '11111',
        informal_address: 'FLAG Kendall, Miami, Florida, United States',
        formal_address: 'This is an Address'
      )
      create(:address_search, query: 'THIS IS AN ADDRESS', address:)
    end

    it 'hits the cache' do
      expect(client).not_to receive(:locate)
      subject.locate(address_query: 'This is an Address    ')
    end
  end
end
