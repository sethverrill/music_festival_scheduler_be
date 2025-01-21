RSpec.describe Api::V1::ShowsController, type: :controller do
  describe 'GET #index' do
    let!(:shows) { create_list(:show, 5) }

    it 'returns all shows' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(5)
    end
  end

  describe 'GET #show' do
    let(:show) { create(:show) }

    it 'returns a show' do
      get :show, params: { id: show.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['id'].to_i).to eq(show.id)
    end

    it 'returns a 404 if the show does not exist' do
      get :show, params: { id: 199124 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE #destroy' do
    let!(:show) { create(:show) }

    it 'deletes a show' do
      expect {
        delete :destroy, params: { id: show.id }
      }.to change(Show, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it 'returns a 404 if the show does not exist' do
      delete :destroy, params: { id: -1 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
