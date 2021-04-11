require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'create user' do
    let!(:role) {create :role, :staff}
    let!(:profession) { create :profession }

    it 'should (signup) - create a new user' do
      username = Faker::Name::name
      email = Faker::Internet.email

      params = {
        user: {
          username: username,
          email: email,
          password: '123456',
          password_confirmation: '123456',
          profession: profession.name
        }
      }
      post '/users', params: params
      json = JSON.parse(response.body)

    
      expect(json['data']['email']).to eq email
      expect(json['data']['username']).to eq username
    end
  end
end