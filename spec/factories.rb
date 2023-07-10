FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    nickname { Faker::Name.name }
  end

  factory :note do
    user
    status { %w(public private archived).sample }
    body { Faker::Lorem.paragraph }
    title { Faker::Lorem.sentence }
  end
end
