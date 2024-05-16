FactoryBot.define do
  factory :user do
    email { 'admin@example.com' }
    password { 'pa88w0rd' }
    password_confirmation { 'pa88w0rd' }
  end
end
