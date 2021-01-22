FactoryBot.define do
    # factory :user do
    #     firstname {Faker::Name.first_name}
    #     lastname {Faker::Name.last_name}
    #     email {Faker::Internet.email}
    #     password {Faker::Internet.password(min_length: 6)}
    #     image {'test.jpg'}
    # end
    factory :user do
        firstname {'Jane'}
        lastname {'Doe'}
        email {'janedoe@gmail.com'}
        password {'1234567'}
        image {'test.jpg'}
    end
end