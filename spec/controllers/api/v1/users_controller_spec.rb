require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe '#show' do
    let(:user) { create(:user) }
    let!(:schedule) { create(:schedule, user: user) }

    context 'happy path' do
      it 'returns user with their schedule' do
        get :show, params: { id: user.id }

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(:ok)
        expect(parsed_response[:data][:id].to_i).to eq(user.id)
        expect(parsed_response[:data][:attributes][:schedule][:id]).to eq(schedule.id)
      end
    end

    context 'sad path' do
      it 'returns a 404 whe user does not exist' do
        get :show, params: { id: 998899 }
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:not_found)
        expect(parsed_response[:error]).to eq('User not found')
      end
    end
  end
end
