# frozen_string_literal: true

##
# One of the system feature is that once we create
# a trip we can't update it
# To ease the computation time we compute the distance once
# the trip is being created
# #
class TripCreator < ApplicationService
  def initialize(trip_params)
    @trip_params = trip_params
  end

  def call
    create_record
    @trip
  end

  private

  def create_record
    @trip = Trip.create!(@trip_params)
  end
end