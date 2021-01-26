# frozen_string_literal: true

class StatsController < ApplicationController
  ##
  # It would propably to do more REST routes
  # and have the monthly/weekly stats as query string
  ##
  def weekly
    render json: { status: 'ok' }, status: :ok
  end

  def monthly
    render json: { status: 'ok' }, status: :ok
  end
end
