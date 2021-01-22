require 'rails_helper'

describe 'Users Controller', type: :request do
    
    it 'should return count of all users' do
        FactoryBot.create(:user)
        get '/api/v1/users'

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
    end

    # it 'create a new user' do
    #     # url = fixture_file_upload('test.jpg', 'image/jpg')
    #     url = Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures",   "test.jpg"), "image/jpg")
    #     expect {
    #         post '/api/v1/users', params: { user: { 
    #             firstname: Faker::Name.first_name,
    #             lastname: Faker::Name.last_name,
    #             email: Faker::Internet.email, 
    #             password: Faker::Internet.password(min_length: 6),
    #             image: url
    #             }
    #         }
    #     }.to change { User.count}.from(0).to(1)
    #     expect(response).to have_http_status(:created)
    # end

    it 'should log a user in' do
        FactoryBot.create(:user)

        post '/api/v1/login', params: {email: 'janedoe@gmail.com', password: '1234567'}

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('token')
        # raise response.body
    end
end