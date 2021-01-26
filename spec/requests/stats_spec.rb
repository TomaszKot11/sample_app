# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stats' do
  describe 'GET /api/stats/weely' do
    subject { get stats_weekly_path }
    before { subject }

    it 'should return HTTP 200 status' do
      expect(response.status).to eq 200
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