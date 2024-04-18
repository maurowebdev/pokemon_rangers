RSpec.shared_context 'authentication_context' do
  let(:ranger) { create(:ranger) }
  let(:headers) { { Authorization: "Bearer #{token}" } }
  let(:token) { JWT.encode({ id: ranger.id, exp: 1.day.from_now.to_i }, Rails.application.credentials.secret_key_base) }
end
