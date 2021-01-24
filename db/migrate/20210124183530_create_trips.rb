class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.text :start_address
      t.text :destination_address
      # in the real app it might be useful to use the money gem
      t.decimal :price, :decimal, precision: 8, scale: 2
      t.datetime :delivery_date
      t.timestamps
    end
  end
end