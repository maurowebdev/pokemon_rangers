require 'rails_helper'

RSpec.describe Incident, type: :model do
  describe 'Validations' do
    subject(:incident) { described_class.new(params) }

    let(:ranger) { create(:ranger) }
    let(:params) { build(:incident, ranger: ranger).attributes }

    context 'when given valid params' do
      it 'should be valid' do
        expect(incident).to be_valid
      end
    end

    context 'when given invalid params' do
      before { incident.valid? }

      let(:params) { { } }

      it 'should be invalid' do
        expect(incident).to be_invalid
      end

      it 'should return blank ranger error' do
        expect(incident.errors.messages[:ranger]).to include("must exist")
      end

      it 'should return blank location error' do
        expect(incident.errors.messages[:location]).to include("can't be blank")
      end

      it 'should return blank occurrence_date error' do
        expect(incident.errors.messages[:occurrence_date]).to include("can't be blank")
      end

      it 'should return blank description error' do
        expect(incident.errors.messages[:description]).to include("can't be blank")
      end
    end
  end
end
