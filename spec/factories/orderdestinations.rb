FactoryBot.define do
  factory :order_destination do
    post_code { Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { Faker::Address.city }
    street { Faker::Address.street_address }
    building { '豊田ビル' }
    phone { Faker::Number.number(digits: [10, 11].sample) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
