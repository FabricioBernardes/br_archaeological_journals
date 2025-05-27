require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:admin) { User.create!(email: 'admin@example.com', password: 'password', role: 'admin') }
  let(:user) { User.create!(email: 'user@example.com', password: 'password', role: 'user') }

  describe 'GET #edit_role' do
    it 'permite acesso para admin' do
      sign_in admin
      get :edit_role, params: { id: user.id }
      expect(response).to have_http_status(:ok)
    end

    it 'nega acesso para não admin' do
      sign_in user
      get :edit_role, params: { id: admin.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'PATCH #update_role' do
    it 'permite admin atualizar role' do
      sign_in admin
      patch :update_role, params: { id: user.id, user: { role: 'contributor' } }
      expect(user.reload.role).to eq('contributor')
    end

    it 'nega atualização para não admin' do
      sign_in user
      patch :update_role, params: { id: admin.id, user: { role: 'user' } }
      expect(admin.reload.role).to eq('admin')
    end
  end
end
