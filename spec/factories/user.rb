FactoryBot.define do
  factory :user do
    email { 'test@gmail.com' }
    password { 'test@123' }
    password_confirmation { 'test@123' }
  end
end