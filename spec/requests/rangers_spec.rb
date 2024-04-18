require 'rails_helper'

RSpec.describe "/rangers", type: :request do
  let(:valid_attributes) do
    {
      email: Faker::Internet.email,
      password: '1234567A@b',
      first_name: Faker::Name.first_name,
      identification_number: Faker::Number.number(digits: 10)
    }
  end

  let(:invalid_attributes) do
    {
      email: 'a@b',
      password: '...+',
      first_name: '',
      identification_number: ''
    }
  end

  let(:valid_headers) {
    {}
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Ranger" do
        expect {
          post sign_up_path,
               params: { ranger: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Ranger, :count).by(1)
      end

      it "renders a JSON response with the new ranger" do
        post rangers_url,
             params: { ranger: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Ranger" do
        expect {
          post rangers_url,
               params: { ranger: invalid_attributes }, as: :json
        }.to change(Ranger, :count).by(0)
      end

      it "renders a JSON response with errors for the new ranger" do
        post rangers_url,
             params: { ranger: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
