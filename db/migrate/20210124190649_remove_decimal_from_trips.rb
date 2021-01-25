class RemoveDecimalFromTrips < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :decimal
  end
end
