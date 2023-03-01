module Types
  class WeatherSummaryType < GraphQL::Schema::Object
    field :address, Types::AddressType
    field :forecasts, [Types::WeatherDetailType]
    field :created_at, String
    field :from_cache, Boolean
  end
end
