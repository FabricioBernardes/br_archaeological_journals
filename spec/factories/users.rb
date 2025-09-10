FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Devise::Encryptor.digest(User, 'password') }
  end
end
