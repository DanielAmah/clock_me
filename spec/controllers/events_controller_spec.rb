require 'rails_helper'

RSpec.describe EventsController, type: :request do
  describe 'create' do
    let!(:event) { create :event }
    let!(:auth_token) { JsonWebToken.encode(user_id: event.user_profession.user.id) }


    it 'should not create a new event if no auth token' do
      post '/events', params: { event: { description: event.description } }
      json = JSON.parse(response.body)
     
      expect(json["message"]).to eq "Nil JSON web token"
    end
    
    it 'creates a event' do
      post '/events', headers: { 'HTTP_AUTHORIZATION' => "Bearer #{auth_token[:token]}" }, params: { event: { description: event.description } }
      expect(event.reload).to have_attributes('description' => event.description)
    end

    it 'returns created event' do
      post '/events', headers: { 'HTTP_AUTHORIZATION' => "Bearer #{auth_token[:token]}" }, params: { event: { description: event.description } }
      json = JSON.parse(response.body)
      data = json['data']

      expect(data['description']).to eq event.description
    end
  end

  describe 'index' do
    describe 'failed' do
      let!(:event) { create :event }
      let!(:auth_token) { JsonWebToken.encode(user_id: event.user_profession.user.id) }

      it 'should not get events if no auth token' do
        get '/events'
        json = JSON.parse(response.body)
      
        expect(json["message"]).to eq "Nil JSON web token"
      end
      

      it 'should not return event if not an admin' do
        get '/events', headers: { 'HTTP_AUTHORIZATION' => "Bearer #{auth_token[:token]}" }
        json = JSON.parse(response.body)
      
        expect(json["message"]).to eq "Need admin privileges!"
      end
    end

    describe 'success' do
      let!(:user) { create :user }
      let!(:role) {create :role, :admin}
      let!(:user_role) {create :user_role, user: user, role: role}
      let!(:user_profession) {create :user_profession, user: user}
      let!(:event) {create :event, user_profession: user_profession}
      let!(:auth_token) { JsonWebToken.encode(user_id: event.user_profession.user.id) }

      it 'should  get all events' do
        get '/events', headers: { 'HTTP_AUTHORIZATION' => "Bearer #{auth_token[:token]}" }
        json = JSON.parse(response.body)
      
        expect(json[0]['description']).to eq event.description
      end
    end
  end

  describe 'current user events' do
    describe 'failed' do
      let!(:event) { create :event }
      let!(:auth_token) { JsonWebToken.encode(user_id: event.user_profession.user.id) }

      it 'should not get events if no auth token' do
        get '/user_events'
        json = JSON.parse(response.body)
      
        expect(json["message"]).to eq "Nil JSON web token"
      end
    end

    describe 'success' do
      let!(:event) { create :event }
      let!(:auth_token) { JsonWebToken.encode(user_id: event.user_profession.user.id) }

      it 'should  get users events' do
        get '/user_events', headers: { 'HTTP_AUTHORIZATION' => "Bearer #{auth_token[:token]}" }
        json = JSON.parse(response.body)
      
        expect(json[0]['description']).to eq event.description
      end
    end
  end

  describe 'trash event' do
    describe 'failed' do
      let!(:event) { create :event }
      let!(:auth_token) { JsonWebToken.encode(user_id: event.user_profession.user.id) }

      it 'should not trash an event if no auth token' do
        put "/events/#{event.id}/trash_event"
        json = JSON.parse(response.body)
        expect(json["message"]).to eq "Nil JSON web token"
      end
      
      it 'should not trash an event if not an admin' do
        put "/events/#{event.id}/trash_event", headers: { 'HTTP_AUTHORIZATION' => "Bearer #{auth_token[:token]}" }
        json = JSON.parse(response.body)

        expect(json["message"]).to eq "Need admin privileges!"
      end
    end

    describe 'success' do
      let!(:user) { create :user }
      let!(:role) {create :role, :admin}
      let!(:user_role) {create :user_role, user: user, role: role}
      let!(:user_profession) {create :user_profession, user: user}
      let!(:event) {create :event, user_profession: user_profession}
      let!(:auth_token) { JsonWebToken.encode(user_id: event.user_profession.user.id) }

      it 'should trash an event' do
        put "/events/#{event.id}/trash_event", headers: { 'HTTP_AUTHORIZATION' => "Bearer #{auth_token[:token]}" }
        json = JSON.parse(response.body)

        expect(json['message']).to eq("Event sent to trash!")
      end
    end
  end

  describe 'delete event' do
    describe 'failed' do
      let!(:event) { create :event }
      let!(:auth_token) { JsonWebToken.encode(user_id: event.user_profession.user.id) }

      it 'should not trash an event if no auth token' do
        put "/events/#{event.id}/trash_event"
        json = JSON.parse(response.body)
        expect(json["message"]).to eq "Nil JSON web token"
      end
      
      it 'should not trash an event if not an admin' do
        put "/events/#{event.id}/trash_event", headers: { 'HTTP_AUTHORIZATION' => "Bearer #{auth_token[:token]}" }
        json = JSON.parse(response.body)

        expect(json["message"]).to eq "Need admin privileges!"
      end
    end

    describe 'success' do
      let!(:user) { create :user }
      let!(:role) {create :role, :admin}
      let!(:user_role) {create :user_role, user: user, role: role}
      let!(:user_profession) {create :user_profession, user: user}
      let!(:event) {create :event, user_profession: user_profession}
      let!(:auth_token) { JsonWebToken.encode(user_id: event.user_profession.user.id) }

      it 'should trash an event' do
        delete "/events/#{event.id}", headers: { 'HTTP_AUTHORIZATION' => "Bearer #{auth_token[:token]}" }
        json = JSON.parse(response.body)

        expect(json['message']).to eq("Event deleted!")
      end
    end
  end 
end