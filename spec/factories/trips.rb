# frozen_string_literal: true

FactoryBot.define do
  factory :trip do
    start_address { "#{Faker::Address.street_address.gsub(',', ' ')}, #{Faker::Address.city.gsub(',', ' ')}, #{Faker::Address.country.gsub(',', ' ')}" }
    destination_address { "#{Faker::Address.street_address.gsub(',', ' ')}, #{Faker::Address.city.gsub(',', ' ')}, #{Faker::Address.country.gsub(',', ' ')}" }
    price { Faker::Commerce.price(range: 0..10.0) }
    delivery_date { Faker::Date.forward(days: 12) }

    trait :invalid do
      start_address { 'Mickiewicza 14, Lodz' }
    end
  end
end