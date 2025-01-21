RSpec.describe Api::V1::VenuesController, type: :controller do
  describe 'GET #index' do
    let!(:venues) { create_list(:venue, 4) }

    it 'returns all venues' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(4)
    end
  end

  describe 'GET #show' do
    let(:venue) { create(:venue) }

    it 'returns a venue' do
      get :show, params: { id: venue.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['id'].to_i).to eq(venue.id)
    end

    it 'returns a 404 if the venue does not exist' do
      get :show, params: { id: 97468 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
