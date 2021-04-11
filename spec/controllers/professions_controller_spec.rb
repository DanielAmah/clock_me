require 'rails_helper'

RSpec.describe EventsController, type: :request do
  describe 'index' do
    let!(:profession) { create :profession }

    it 'should display all professions' do
      get '/professions'
      json = JSON.parse(response.body)
      expect(json[0]['name']).to eq profession.name
    end

  end
end