# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  formal_address   :string
#  informal_address :string
#  latitude         :float
#  longitude        :float
#  zipcode          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Address < ApplicationRecord
end
