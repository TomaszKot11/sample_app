# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stats' do
  describe 'GET /api/stats/weely' do
    let!(:trips_this_week) { create_list :trip, 5, delivery_date: Date.current }
    let!(:trips_previous_week) { create_list :trip, 5, delivery_date: Date.current - 8.days }
    let(:proper_json_struct) do
      {
        'total_distance' => "#{trips_this_week.pluck(:distance).inject('+')}km",
        'total_price' => "#{trips_this_week.pluck(:price).inject('+')}PLN"
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
          'total_distance' => "0km".to_s,
          'total_price' => "0PLN".to_s
        }
      end

      it 'should return proper json response' do
        expect(json_response).to eq(proper_json_struct)
      end
    end
  end

  describe 'GET /api/stats/monthly' do
    let!(:trips_this_month) { create_list :trip, 5, delivery_date: Date.current }
    let!(:trips_previous_month) { create_list :trip, 5, delivery_date: Date.current - 1.month }
    let(:proper_json_struct) do
      [
        {
          "day" => trips_this_month.first.delivery_date.strftime('%B, %d'),
          "total_distance" => "#{trips_this_month.pluck(:distance).inject('+')}km",
          "avg_ride" => "#{(trips_this_month.pluck(:distance).inject('+')&.round(2)/ 5.0).round(2)}km",
          "avg_price" => "#{( trips_this_month.pluck(:price).inject('+')&.round(2)/ 5.0).round(2)}PLN"
        }
      ]
    end
    subject { get stats_monthly_path }
    before { subject }

    it 'should return HTTP 200 status' do
      expect(response.status).to eq 200
    end

    it 'should return proper json structure' do
      expect(json_response).to match_array(proper_json_struct)
    end

    # shared_context could be propably used
    context 'when there is no trip data' do
      let!(:trips_this_month) { nil }
      let!(:trips_next_month) { nil }
      let(:proper_json_struct) { [] }

      it 'should return proper json response' do
        expect(json_response).to match_array(proper_json_struct)
      end
    end
  end
end