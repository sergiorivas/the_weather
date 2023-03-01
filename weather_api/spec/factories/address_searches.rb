# == Schema Information
#
# Table name: address_searches
#
#  id         :bigint           not null, primary key
#  query      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  address_id :bigint
#
# Indexes
#
#  index_address_searches_on_address_id  (address_id)
#
FactoryBot.define do
  factory :address_search do
    query { "my search" }
  end
end
