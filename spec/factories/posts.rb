# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    url "MyString"
    provider "MyString"
    media_type "MyString"
    title "MyString"
    views 1
  end
end
