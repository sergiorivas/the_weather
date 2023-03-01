module Types
  class WeatherDetailType < GraphQL::Schema::Object
    field :temperature, Integer
    field :temperature_unit, String
    field :start_time, String
    field :end_time, String
    field :name, String
    field :relative_humitidy, Integer
    field :wind_speed, String
    field :wind_direction, String
    field :icon_url, String
    field :summary, String
    field :forecast_description, String
  end
end
