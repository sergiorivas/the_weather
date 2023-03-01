require 'rails_helper'

RSpec.describe WeatherService::WeatherGov::Client do
  subject { described_class.new }

  context 'when forecast is available' do
    before do
      allow(subject).to receive(:request_forecast).and_return(
        %(
          {
            "properties": {
              "periods": [
                {
                  "name": "Today",
                  "startTime": "2023-03-01T06:00:00-06:00",
                  "endTime": "2023-03-01T18:00:00-06:00",
                  "temperature": 55,
                  "temperatureUnit": "F",
                  "relativeHumidity": {
                      "unitCode": "wmoUnit:percent",
                      "value": 66
                  },
                  "windSpeed": "5 to 10 mph",
                  "windDirection": "N",
                  "icon": "https://api.weather.gov/icons/land/day/few?size=medium",
                  "shortForecast": "Sunny",
                  "detailedForecast": "Sunny, with a high near 55. North wind 5 to 10 mph, with gusts as high as 20 mph."
                }
              ]
            }
          }
        )
      )
    end

    it 'creates an address' do
      expect(subject.forecast(latitude: 1, longitude: 1).to_json).to eql(
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
        ].to_json
      )
    end
  end

  context 'when there is not connection to the API' do
    before do
      allow(subject).to receive(:request_forecast).and_raise
    end

    it 'raise an error' do
      expect { subject.forecast(latitude: 1, longitude: 1) }.to raise_error
    end
  end
end
