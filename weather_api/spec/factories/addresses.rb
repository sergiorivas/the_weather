# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  formal_address   :string
#  informal_address :string
#  latitude         :integer
#  longitude        :integer
#  zipcode          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :address do
    latitude { 1 }
    longitude { 1 }
    zipcode { "11111" }
    formal_address { "formal address" }
    informal_address { "informal address" }
  end
end
