FactoryBot.define do
    factory :message do
        user_id { 1 }
        receiver_id { 2 }
        content {Faker::Lorem.sentence(word_count: 10)}
        request_id { 1 }
    end
end