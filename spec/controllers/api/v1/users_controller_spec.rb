require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe '#index' do
    let!(:users) { create_list(:user, 5) }
    let!(:schedules) { users.map { |user| create(:schedule, user: user) } }
    let!(:shows) { create_list(:show, 5) }

    before do
      schedules.each { |schedule| schedule.shows << shows.sample }
    end

    it 'returns all users with their schedules' do
      get :index
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(parsed_response[:data].size).to eq(5)

      parsed_response[:data].each do |user|
        expect(user[:attributes][:schedule][:id]).not_to be_nil
        
        user[:attributes][:schedule][:shows].each do |show|
          expect(show).to have_key(:id)
          expect(show).to have_key(:time_slot)
          expect(show[:artist]).to have_key(:id)
          expect(show[:artist]).to have_key(:name)
          expect(show[:venue]).to have_key(:id)
          expect(show[:venue]).to have_key(:name)
        end
      end
    end
  end
  
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
