require 'rails_helper'

describe 'Users Controller', type: :request do
    before(:each) do
        FactoryBot.create(:user)
    end
    
    it 'should return count of all users' do
        get '/api/v1/users'

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
    end

    it 'create a new user' do
        url = Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures",   "test.jpg"), "image/jpg")
        expect {
            post '/api/v1/users', params: { 
                firstname: Faker::Name.first_name,
                lastname: Faker::Name.last_name,
                email: Faker::Internet.email, 
                password: Faker::Internet.password(min_length: 6),
                image: 'test.jpg'
                }
            
        }.to change { User.count}.from(1).to(2)
        expect(response).to have_http_status(:created)
    end

    it 'should allow a user to log in' do
        post '/api/v1/login', params: {email: 'Jane@gmail.com', password: '1234567'}
        expect(response).to have_http_status(:ok)
    end

    it 'should include user token in response upon successful login' do
        post '/api/v1/login', params: {email: 'Jane@gmail.com', password: '1234567'}
        expect(response.body).to include('token')
    end
end