# frozen_string_literal: true

class StatsController < ApplicationController
  ##
  # It would propably to do more REST routes
  # and have the monthly/weekly stats as query string
  ##
  def weekly
    render json: StatsService.call(period: :weekly), status: :ok
  end

  def monthly
    render json: StatsService.call, status: :ok
  end
end
