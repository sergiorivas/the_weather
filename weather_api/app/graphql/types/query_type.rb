module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :forecast, Types::WeatherSummaryType do
      argument :address_query, String, required: true
    end
    def forecast(address_query:)
      WeatherService::Service.new.forecast(address_query:)
    end
  end
end
