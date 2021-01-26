class TripSerializer
  include JSONAPI::Serializer
  attributes :start_address, :destination_address, :price, :created_at, :delivery_date, :updated_at
end
