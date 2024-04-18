# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe 'POST /create' do
    let(:ranger) { create(:ranger) }
    let(:encoded_credentials) { Base64.encode64("#{ranger.email}:1234567A@b") }
    let(:bad_encoded_credentials) { Base64.encode64("#{ranger.email}:1234567A@bCD") }
    let(:headers) { { Authorization: "Basic #{encoded_credentials}" } }
    let(:bad_headers) { { Authorization: "Basic #{bad_encoded_credentials}" } }

    it 'returns http success' do
      post sign_in_path, headers: headers
      expect(response).to have_http_status(:success)
    end

    it 'returns http failure when user is not found' do
      post sign_in_path, headers: bad_headers
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
