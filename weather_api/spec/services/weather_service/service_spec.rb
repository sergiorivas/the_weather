require 'rails_helper'

RSpec.describe WeatherService::Service do
  subject { described_class.new(client: weather_client, location_service:) }

  let(:location_client) { LocationService::Radar::Client.new }
  let(:location_service) { LocationService::Service.new(client: location_client) }
  let(:weather_client) { WeatherService::WeatherGov::Client.new }
  let(:address) do
    LocationService::Base::Address.new(
      latitude: 1.0,
      longitude: 2.0,
      zipcode: '11111',
      informal_address: 'FLAG Kendall, Miami, Florida, United States',
      formal_address: 'This is an Address'
    )
  end
  let(:forecasts) do
    [
      WeatherService::Base::WeatherDetail.new(
        end_time: Time.new('2023-03-01 18:00:00 -0600'),
        forecast_description: 'Sunny, with a high near 55. North wind 5 to 10 mph, with gusts as high as 20 mph.',
        icon_url: 'https://api.weather.gov/icons/land/day/few?size=medium',
        name: 'Today',
        relative_humitidy: 66,
        start_time: Time.new('2023-03-01 06:00:00 -0600'),
        summary: 'Sunny',
        temperature: 55,
        temperature_unit: 'F',
        wind_direction: 'N',
        wind_speed: '5 to 10 mph'
      )
    ]
  end

  before do
    allow(location_client).to receive(:locate) { address }
    allow(weather_client).to receive(:forecast) { forecasts }
  end

  context 'when there is a forecast' do
    it 'retreives the weather info' do
      weather_info = subject.forecast(address_query: 'This is an Address')
      expect(weather_info.address.to_json).to eq(address.to_json)
      expect(weather_info.forecasts.to_json).to eq(forecasts.to_json)
    end
  end
end
