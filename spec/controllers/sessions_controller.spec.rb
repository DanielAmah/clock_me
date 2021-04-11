require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe 'login' do
    let!(:role) {create :role, :staff}
    let!(:profession) { create :profession }
    let!(:user) { create :user, password: '123456', password_confirmation: '123456' }

    it 'should (login) - a user' do
     
      post '/login', params: { user: { username: user.username, password: user.password } }
      json = JSON.parse(response.body)

      expect(json['user']['email']).to eq user.email
      expect(json['user']['username']).to eq user.username
      expect(json['token']).to eq JsonWebToken.encode(user_id: user.id)
    end
  end
end