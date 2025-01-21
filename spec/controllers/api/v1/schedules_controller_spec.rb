require 'rails_helper'

RSpec.describe Api::V1::SchedulesController, type: :controller do
  describe '#show' do
    let(:user) { create(:user) }
    let!(:schedule) { create(:schedule, user: user) }
    let!(:shows) { create_list(:show, 3, schedule: schedule) }

    context 'GET #show happy path' do
      it 'returns the schedule with shows' do
        get :show, params: { user_id: user.id }
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:ok)
        expect(parsed_response[:data][:attributes][:id]).to eq(schedule.id)
        expect(parsed_response[:data][:relationships][:shows][:data].size).to eq(3)
      end
    end

    context 'GET #show sad path' do
      it 'returns a 404 error when user schedule not found' do
        get :show, params: { user_id: -1 }
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:not_found)
        expect(parsed_response[:error]).to eq('Schedule not found')
      end
    end
  end
end
