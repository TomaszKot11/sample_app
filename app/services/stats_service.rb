# frozen_string_literal: true

class StatsService < ApplicationService
  def initialize(period: :month)
    @period = period
  end

  def call
    @trips_records = trips_records
    stats
  end

  private

  def trips_records
    period = @period == :weekly ? [Date.current.at_beginning_of_week.strftime, (Date.current.at_beginning_of_week + 7.days).strftime] : [Date.current.at_beginning_of_month.strftime, Date.current.end_of_month.strftime]
    trips = Trip.where('delivery_date BETWEEN ? AND ?', *period)
    trips
  end

  def stats
    if @period == :month
      {}
    else
      {
        total_distance: total_distance,
        total_price: total_price
      }
    end
  end

  def total_distance
    distance_computed = @trips_records.pluck(:distance).inject('+')&.round(2)&.to_s
    distance_computed.nil? ? '0' : distance_computed
  end

  def total_price
    price_computed = @trips_records.pluck(:price).inject('+')&.round(2)&.to_s
    price_computed.nil? ? '0' : price_computed
  end
end
