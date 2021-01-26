# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trips' do
  describe 'POST /api/trip' do
    subject { post trips_path, params: post_params }
    let(:post_params) {  }
    before do |example|
      subject unless example.metadata[:skip_request]
    end

    context 'with valid attributes' do
        let(:valid_attributes) { FactoryBot.attributes_for(:trip) }
        let(:valid_json_response) { valid_attributes.except(:distance, :delivery_date).transform_keys(&:to_s).transform_values(&:to_s) }
        let(:post_params) { { trip: valid_attributes } }

        it 'returns HTTP 201 status' do
          expect(response.status).to eq 201
        end

        it 'creates a new trip object', skip_request: true do
          expect { subject }.to change(Trip, :count).by(+1)
        end

        it 'returns new trip in the response' do
          expect(json_response.dig('data', 'attributes')).to include valid_json_response
        end
      end

      context 'with invalid attributes' do
        let(:error_json) { { 'error' => 'Validation failed: Start address is invalid' } }
        let(:post_params) { { trip: FactoryBot.attributes_for(:trip, :invalid) } }

        it 'returns  HTTP 422 status' do
          expect(response.status).to eq 422
        end

        it 'returns proper error message' do
          expect(json_response).to eq(error_json)
        end
      end
  end
end