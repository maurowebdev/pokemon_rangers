# frozen_string_literal: true
require 'rails_helper'
require 'authentication_context'

RSpec.describe IncidentsController, type: :request do
  include_context 'authentication_context'
  let(:valid_attributes) { build(:incident).attributes }

  let(:invalid_attributes) { { description: '', occurrence_date: nil } }

  describe 'GET /index' do
    before { create(:incident, ranger: ranger) }
    it 'renders a successful response' do
      get incidents_url, headers: headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    before { create_list(:incident, 50, ranger: ranger) }
    it 'renders a successful response' do
      get incident_url(ranger.incidents.sample.id), headers: headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Incident' do
        expect {
          post incidents_url,
               params: { incident: valid_attributes }, headers: headers, as: :json
        }.to change(Incident, :count).by(1)
      end

      it 'renders a JSON response with the new incident' do
        post incidents_url,
             params: { incident: valid_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Incident' do
        expect {
          post incidents_url,
               params: { incident: invalid_attributes }, headers: headers, as: :json
        }.to change(Incident, :count).by(0)
      end

      it 'renders a JSON response with errors for the new incident' do
        post incidents_url,
             params: { incident: invalid_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:incident) { create(:incident, ranger: ranger) }
      let(:new_attributes) { build(:incident).attributes.except('ranger_id') }

      it 'updates the requested incident' do
        put incident_url(incident), params: { incident: new_attributes }, headers: headers, as: :json

        expect(JSON.parse(response.body)['incident']['description']).to eq(new_attributes['description'])
        expect(response).to have_http_status(:ok)
      end

      it 'renders a JSON response with the incident' do
        patch incident_url(incident),
              params: { incident: new_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let(:incident) { create(:incident, ranger: ranger) }

      it 'renders a JSON response with errors for the incident' do
        patch incident_url(incident),
              params: { incident: invalid_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:incident) { create(:incident, ranger: ranger) }

    it 'destroys the requested incident' do
      expect {
        delete incident_url(incident), headers: headers, as: :json
      }.to change(Incident, :count).by(-1)
    end
  end
end
