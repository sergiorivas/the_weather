class AdjustAddressCoordinatesToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :addresses, :latitude, :float
    change_column :addresses, :longitude, :float
  end
end
