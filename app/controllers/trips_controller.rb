# frozen_string_literal: true

class TripsController < ApplicationController

  def create
    trip_created = Trip.create!(trip_params)
    render json: trip_created, status: :created
  end

  private

  def trip_params
    params.require(:trip).permit(:start_address, :destination_address, :price, :delivery_date)
  end
end
