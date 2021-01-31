# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stats' do
  describe 'GET /api/stats/weely' do
    let!(:trips_this_week) { create_list :trip, 5, delivery_date: Date.current }
    let!(:trips_previous_week) { create_list :trip, 5, delivery_date: Date.current - 8.days }
    let(:proper_json_struct) do
      {
        'total_distance' => trips_this_week.pluck(:distance).inject('+').to_s,
        'total_price' => trips_this_week.pluck(:price).inject('+').to_s
      }
    end
    subject { get stats_weekly_path }
    before { subject }

    it 'should return HTTP 200 status' do
      expect(response.status).to eq 200
    end

    it 'should return propr json structure for week stats' do
      expect(json_response).to eq(proper_json_struct)
    end

    # shared_context could be propably used
    context 'when there is no trip data' do
      let!(:trips_this_week) { nil }
      let!(:trips_previous_week) { nil }
      let(:proper_json_struct) do
        {
          'total_distance' => 0.to_s,
          'total_price' => 0.to_s
        }
      end

      it 'should return proper json response' do
        expect(json_response).to eq(proper_json_struct)
      end
    end
  end

  describe 'GET /api/stats/monthly' do
    subject { get stats_monthly_path }
    before { subject }

    it 'should return HTTP 200 status' do
      expect(response.status).to eq 200
    end
  end
end