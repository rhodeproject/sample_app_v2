FactoryGirl.define do
  factory :user do
    name  "Matt Hatch"
    email "mhatch73@gmail.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end
