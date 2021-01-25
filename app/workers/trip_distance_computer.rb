# frozen_string_literal: true

class TripDistanceComputer
  include Sidekiq::Worker

  def perform(trip_id)
    trip = Trip.find(trip_id)
    from_loc = trip.start_address
    to_loc = trip.destination_address
    from_geo_cord = Geocoder.coordinates(from_loc)
    to_geo_cord = Geocoder.coordinates(to_loc)
    distance = Geocoder::Calculations.distance_between(from_geo_cord, to_geo_cord, units: :km)
  end
end