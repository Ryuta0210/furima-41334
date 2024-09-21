FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    email { Faker::Internet.email }
    password do
      Faker::Alphanumeric.alpha(number: 1) +
        Faker::Number.number(digits: 1).to_s +
        Faker::Internet.password(min_length: 4, max_length: 8)
    end
    password_confirmation { password }
    nickname { person.first.hiragana }
    first_name { person.first.kanji }
    family_name { person.last.kanji }
    first_kana_name { person.first.katakana }
    family_kana_name { person.last.katakana }
    birth_day { Faker::Date.birthday }
  end
end
