FactoryGirl.define do
  factory :user do
    name "Some User"
    login { "user_1" }
    email { "#{login}@example.com" }
    password "someweirdpassword"
    password_confirmation "someweirdpassword"
  end
end