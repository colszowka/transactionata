Factory.define :user do |u|
  u.name "Some User"
  u.login { "user_1" }
  u.email {|f| "#{f.login}@example.com" }
  u.password "someweirdpassword"
  u.password_confirmation "someweirdpassword"
end