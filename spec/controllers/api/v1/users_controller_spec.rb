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
  end
end