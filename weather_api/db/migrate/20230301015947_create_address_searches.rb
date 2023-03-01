class CreateAddressSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :address_searches do |t|
      t.string :query, unique: true
      t.belongs_to :address, index: true

      t.timestamps
    end
  end
end
