# frozen_string_literal: true

class StatsService < ApplicationService
  def initialize(period: :monthly)
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
    if @period == :monthly
      per_day_month_stats
    else
      {
        total_distance: "#{total_distance(@trips_records)}km",
        total_price: "#{total_price(@trips_records)}PLN"
      }
    end
  end

  def total_distance(records)
    distance_computed = records.pluck(:distance).inject('+')&.round(2)
    distance_computed.nil? ? 0 : distance_computed
  end

  def total_price(records)
    price_computed = records.pluck(:price).inject('+')&.round(2)
    price_computed.nil? ? 0 : price_computed
  end

  # Perhaps it could be done via SQL to be more performant
  def per_day_month_stats
    result = []
    @trips_records.pluck(:delivery_date).uniq.each do |delivery_date|
      day_trip_records = @trips_records.where(delivery_date: delivery_date)
      count_records = day_trip_records.size
      result <<
      (
        {
          day: delivery_date.strftime('%B, %d'),
          total_distance: "#{total_distance(day_trip_records)}km",
          avg_ride:      "#{(total_distance(day_trip_records) / count_records).round(2)}km",
          avg_price:  "#{(total_price(day_trip_records) / count_records).round(2)}PLN"
        }
      )
    end
    result
  end
end
