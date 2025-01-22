require 'rails_helper'

RSpec.describe Api::V1::SchedulesController, type: :controller do
  describe '#show' do
    let(:user) { create(:user) }
    let!(:schedule) { create(:schedule, user: user) }
    let!(:shows) { create_list(:show, 3, schedules: [schedule]) }

    context 'GET #show happy path' do
      it 'returns the schedule with shows' do
        get :show, params: { user_id: user.id }
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:ok)

        serialized_shows = parsed_response[:data][:attributes][:shows]

        expect(serialized_shows.size).to eq(3)
        expect(serialized_shows.map { |show| show[:id].to_i }).to match_array(shows.map(&:id))
      end
    end

    context 'GET #show sad path' do
      it 'returns a 404 error when user schedule not found' do
        get :show, params: { user_id: 998899 }
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:not_found)
        expect(parsed_response[:error]).to eq('Schedule not found')
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) {create(:user) }
    let!(:schedule) { create(:schedule, user: user) }
    let!(:temp_schedule) { create(:schedule) }
    let(:show) { create(:show) }

    context 'can add a show' do
      let!(:show) { create(:show) }
    
      it 'adds a show to the schedule' do
        patch :update, params: { user_id: user.id, show_id: show.id, action_type: 'add' }
    
        expect(response).to have_http_status(:ok)
        expect(schedule.shows).to include(show)
      end
    end

    context 'removes a show' do
      before { schedule.shows << show }
    
      it 'removes the show from the schedule' do
        patch :update, params: { user_id: user.id, show_id: show.id, action_type: 'remove' }
    
        expect(response).to have_http_status(:ok)
        expect(schedule.shows).not_to include(show)
      end
    end

    context 'when the schedule already has 8 shows' do
      before do
        shows = create_list(:show, 8)
        shows.each { |show| schedule.shows << show }
      end

      it 'returns a 422 error when adding a 9th show' do
        patch :update, params: { user_id: user.id, show_id: show.id, action_type: 'add' }
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response[:error]).to eq('Schedule cannot have more than 8 shows')
      end
    end

    context 'when the show is not found' do
      it 'returns a 404 error' do
        patch :update, params: { user_id: user.id, show_id: -1, action_type: 'add' }
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:not_found)
        expect(parsed_response[:error]).to eq('Schedule or Show not found')
      end
    end

    context 'when the action type is invalid' do
      it 'returns a 422 error' do
        patch :update, params: { user_id: schedule.user.id, show_id: show.id, action_type: 'invalid' }
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response[:error]).to eq('Invalid action type')
      end
    end
  end
end
