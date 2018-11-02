require "securerandom"

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    email { "#{name.parameterize}@example.edu" }
    password { SecureRandom.alphanumeric(16) }
  end
end
