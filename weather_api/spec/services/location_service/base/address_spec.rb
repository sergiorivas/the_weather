require 'rails_helper'

RSpec.describe LocationService::Base::Address do
  describe '.sanitize' do
    it 'sanitizes the string' do
      sanitized_address = described_class.sanitize(address: '  a rArE   query    ')
      expect(sanitized_address).to eq('A RARE QUERY')
    end
  end
end
