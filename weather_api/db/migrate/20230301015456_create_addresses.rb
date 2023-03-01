class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :latitude
      t.integer :longitude
      t.string :zipcode
      t.string :formal_address, unique: true
      t.string :informal_address

      t.timestamps
    end
  end
end
