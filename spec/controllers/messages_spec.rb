require 'rails_helper'

describe 'Messages Controller', type: :request do

    before(:each) do
        FactoryBot.create(:user)
        FactoryBot.create(:request)
        FactoryBot.create(:message)
        post '/api/v1/login', params: {email: 'janedoe@gmail.com', password: '1234567'}
        @token = JSON.parse(response.body)['token']
    end

    it 'should send a message' do
        expect {
            post '/api/v1/messages', params: {
                user_id: 1,
                receiver_id: 2,
                content: Faker::Lorem.sentence(word_count: 10),
                request_id: 1,
            }, as: :json, headers: {:Authorization => @token}
        }.to change {Message.count}.from(1).to(2)
        
        expect(response).to have_http_status(:created)
    end

    it 'should return all a users message' do
        get '/api/v1/my-messages', as: :json, headers: {:Authorization => @token}
        expect(response).to have_http_status(:ok)
    end

    it 'should return all chat messages' do
        get '/api/v1/chat/1/1', as: :json, headers: {:Authorization => @token}
        expect(response).to have_http_status(:ok)
    end

end