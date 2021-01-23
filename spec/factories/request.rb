FactoryBot.define do
    factory :request do
        title {'I need your help'}
        reqtype {'material'}
        description {Faker::Lorem.sentence(word_count: 300)}
        lat {Faker::Address.latitude}
        lng {Faker::Address.longitude}
        address {Faker::Address.street_address}
        status { 0 }
        user_id { 1 }
    end
end