# frozen_string_literal: true

class TripsController < ApplicationController
  def create
    trip_created = TripCreator.call(trip_params)
    trip_json = TripSerializer.new(trip_created).serializable_hash.to_json
    render json: trip_json, status: :created
  end

  private

  def trip_params
    params.require(:trip).permit(:start_address, :destination_address, :price, :delivery_date)
  end
end
