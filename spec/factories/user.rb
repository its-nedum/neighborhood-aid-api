FactoryBot.define do
    factory :user do
        firstname {Faker::Name.first_name}
        lastname {Faker::Name.last_name}
        email {'janedoe@gmail.com'}
        password {'1234567'}
        image {'test.jpg'}
    end
end