# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ranger, type: :model do
  describe 'Validations' do
    subject(:ranger) { described_class.new(params) }

    let(:params) do
      {
        email: Faker::Internet.email,
        password: '1234567A@b',
        first_name: Faker::Name.first_name,
        identification_number: Faker::Number.number(digits: 10)
      }
    end

    context 'when given valid params' do
      it 'should be valid' do
        expect(ranger).to be_valid
      end
    end

    context 'when given invalid params' do
      before { ranger.valid? }

      let(:params) do
        {
          email: 'a@b',
          password: '...+',
          first_name: '',
          identification_number: ''
        }
      end

      it 'should be invalid' do
        expect(ranger).to be_invalid
      end

      it 'should return invalid email error' do
        expect(ranger.errors.messages[:email]).to include('is invalid')
      end

      it 'should return short password error' do
        expect(ranger.errors.messages[:password]).to include('is too short (minimum is 10 characters)')
      end

      it 'should return one uppercase password error' do
        expect(ranger.errors.messages[:password]).to include('Must contain at least one uppercase letter')
      end

      it 'should return one uppercase password error' do
        expect(ranger.errors.messages[:password]).to include('Must contain at least one lowercase letter')
      end

      it 'should return special character password error' do
        expect(ranger.errors.messages[:password]).to include('Must contain at least one of the following characters: !, @, #, ? or ]')
      end

      it 'should return blank first_name error' do
        expect(ranger.errors.messages[:first_name]).to include("can't be blank")
      end

      it 'should return blank identification_number error' do
        expect(ranger.errors.messages[:first_name]).to include("can't be blank")
      end
    end
  end
end
