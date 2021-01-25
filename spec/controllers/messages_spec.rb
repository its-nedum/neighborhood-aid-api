require 'rails_helper'

describe 'Messages Controller', type: :request do

    before(:each) do
       user = FactoryBot.create(:user)
       user1 = FactoryBot.create(:user1)
       request = FactoryBot.create(:request)
       request1 = FactoryBot.create(:request1)
       message = FactoryBot.create(:message)
       message1 = FactoryBot.create(:message1)
       post '/api/v1/login', params: {email: 'Jane@gmail.com', password: '1234567'}
       @token = JSON.parse(response.body)['token']
    end

    it 'should exchange message between the users' do
        expect {
            post '/api/v1/messages', params: {
                user_id: 1,
                receiver_id: 2,
                content: Faker::Lorem.sentence(word_count: 10),
                request_id: 1,
            }, as: :json, headers: {:Authorization => @token}
        }.to change {Message.count}.from(2).to(3)
        expect(response).to have_http_status(:created)
    end

    it 'should return all a user message' do
        get '/api/v1/my-messages', as: :json, headers: {:Authorization => @token}
        expect(response).to have_http_status(:ok)
    end

    it 'should return all chat messages between users' do
        get "/api/v1/chat/#{1}/#{2}", as: :json, headers: {:Authorization => @token}
        expect(response).to have_http_status(:ok)
    end

end