module Types
  class AddressType < GraphQL::Schema::Object
    field :created_at, String
    field :latitude, Float
    field :longitude, Float
    field :formal_address, String
    field :zipcode, String
    field :informal_address, String, null: true
  end
end
